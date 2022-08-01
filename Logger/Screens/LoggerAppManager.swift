//
//  LoggerAppManager.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

class LoggerAppManager: LocalWebSocketDelegate {
    static let shared = LoggerAppManager()

    private var localServer = LocalSever()

    func socketStatusDidUpdate(status: LocalWebSocket.Status) {
        NotificationManager.shared.postEvent(eventName: Notification.Name.SocketStatusDidUpdate, data: status)
    }

    func startLocalServer() {
        localServer.delegate = self
        localServer.startLocalServer()
    }

    func stopLocalServer() {
        localServer.stopLocalServer()
    }

    func sendCommandToClient(_ command: String) throws {
        try? localServer.sendCommandToClient(command: command)
    }
}
