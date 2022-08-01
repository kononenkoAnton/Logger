//
//  LocalWebSocket.swift
//  Logger
//
//  Created by Alex Zchut on 19/05/2022.
//

import Foundation
import Network

protocol LocalWebSocketDelegate {
    func socketStatusDidUpdate(status: LocalWebSocket.Status)
}

class LocalWebSocket {
    enum Status {
        case notConnected
        case connected
        case error
    }

    var delegate: LocalWebSocketDelegate?
    var listener: NWListener
    var connectedClients: [NWConnection] = []
    var completion: ((String) -> Void)?
    var port: UInt16?

    init(port: UInt16 = 9080) {
        self.port = port
        let parameters = NWParameters(tls: nil)
        parameters.allowLocalEndpointReuse = true
        parameters.includePeerToPeer = true

        let wsOptions = NWProtocolWebSocket.Options()
        wsOptions.autoReplyPing = true

        parameters.defaultProtocolStack.applicationProtocols.insert(wsOptions, at: 0)

        do {
            if let port = NWEndpoint.Port(rawValue: port) {
                listener = try NWListener(using: parameters, on: port)
            } else {
                fatalError("Unable to start WebSocket server on port \(port)")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func start() {
        let serverQueue = DispatchQueue(label: "ServerQueue")

        listener.newConnectionHandler = { newConnection in
            print("New connection connecting")

            func receive() {
                newConnection.receiveMessage { data, context, _, _ in
                    if let data = data, let context = context {
                        try? self.handleMessageFromClient(data: data, context: context, stringVal: "", connection: newConnection)
                        receive()
                    }
                }
            }
            receive()

            newConnection.stateUpdateHandler = { [weak self] state in
                guard let self = self else { return }

                switch state {
                case .preparing: print("\n..... Connection Incoming - Preparing .....\n")
                case .setup: print("Connection Incoming -Setup")
                case .ready:
                    do {
                        print("Client ready")
                        let encoder = JSONEncoder()
                        let data = try encoder.encode(WSHandshake(id: UUID()))
                        try? self.sendMessageToClient(data: data, client: newConnection)
                        self.connectedClients.append(newConnection)
                        self.delegate?.socketStatusDidUpdate(status: .connected)
                    } catch {
                    }
                case let .failed(error):
                    self.delegate?.socketStatusDidUpdate(status: .notConnected)
                    print("Client connection failed \(error.localizedDescription)")
                case let .waiting(error):
                    print("Waiting for long time \(error.localizedDescription)")
                case .cancelled: print("you need to remove the connection from the array")

                default:
                    break
                }
            }

            newConnection.start(queue: serverQueue)
        }

        listener.stateUpdateHandler = { state in
            print(state)
            switch state {
            case .ready:
                print("Server Ready")
            case let .failed(error):
                print("Server failed with \(error.localizedDescription)")
            default:
                break
            }
        }

        listener.start(queue: serverQueue)
    }

    func stop() {
        connectedClients.removeAll()
        listener.cancel()
    }

    func sendCommandToClient(command: String) throws {
        guard command.isEmpty == false else {
            return
        }

        let encoder = JSONEncoder()
        let data = try encoder.encode(WSCommand(command: command))
        connectedClients.forEach {
            try? self.sendMessageToClient(data: data, client: $0)
        }
    }

    func sendMessageToClient(data: Data, client: NWConnection) throws {
        let metadata = NWProtocolWebSocket.Metadata(opcode: .text)
        let context = NWConnection.ContentContext(identifier: "context", metadata: [metadata])

        client.send(content: data, contentContext: context, isComplete: true, completion: .contentProcessed({ error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                // no-op
            }
        }))
    }

    func handleMessageFromClient(data: Data, context: NWConnection.ContentContext, stringVal: String, connection: NWConnection) throws {
        let decoder = JSONDecoder()
        do {
            let sinData = try decoder.decode(WSMessageTypeData.self, from: data)
            switch sinData.type {
            case .event:
                let newEventData = try decoder.decode(WSMessageEvent.self, from: data)
                let jsonEventObject = convertStringToDictionary(text: newEventData.event)
                NotificationManager.shared.postEvent(eventName: Notification.Name.PostLogEvent, data: [jsonEventObject])

            case .storage:
                let storageData = try decoder.decode(WSStorage.self, from: data)
                NotificationManager.shared.postEvent(eventName: Notification.Name.PostStorageEvents, data: storageData.data)
            default:
                break
            }
        } catch {
            print("Invalid value from client")
        }
    }

    func convertStringToDictionary(text: String) -> [String: AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
}
