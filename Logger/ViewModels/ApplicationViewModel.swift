//
//  ApplicationViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import AppKit
import Foundation

class ApplicationViewModel: ObservableObject {
    @Published var loggerViewModel = LoggerViewModel()
    @Published var networkViewModel = NetworkViewModel()

    @Published var sideMenuViewModel = SideMenuViewModel()

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(populateRemoteData(_:)), name: NSNotification.Name("PostEvent"), object: nil)
    }

    @objc func populateRemoteData(_ notification: NSNotification) {
        guard let data = notification.object as? [[String: AnyObject]] else {
            return
        }
        addNewEntries(data: data)
    }

    func convertDataToArray(data: Data) -> [[String: AnyObject]]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]]
            return json
        } catch {
            print("Something went wrong")
        }
        return nil
    }

    // MARK: - Intents(s)

    var searchBarFilterData: String? {
        get {
            switch sideMenuViewModel.selectedData.screenType {
            case .logger:
                return loggerViewModel.searchBarFilterData
            case .networkLogger:
                return networkViewModel.searchBarFilterData
            default:
                break
            }
            return nil
        }
        set {
            switch sideMenuViewModel.selectedData.screenType {
            case .logger:
                return loggerViewModel.searchBarFilterData = newValue
            case .networkLogger:
                return networkViewModel.searchBarFilterData = newValue
            default:
                break
            }
        }
    }

    func events() -> [EventModel] {
        switch sideMenuViewModel.selectedData.screenType {
        case .logger:
            return loggerViewModel.events()
        case .networkLogger:
            return networkViewModel.events()
        default:
            break
        }
        return []
    }

    func copyIpAdress() {
        let result = getIPAddress()
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string],
                                owner: nil)
        pasteboard.setString(result, forType: NSPasteboard.PasteboardType.string)
    }

    func clearLoggerData() {
        switch sideMenuViewModel.selectedData.screenType {
        case .logger:
            loggerViewModel.clearLoggerData()
        case .networkLogger:
            networkViewModel.clearLoggerData()
        default:
            break
        }
    }

    func addNewEntries(data: [[String: AnyObject]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.loggerViewModel.addNewEntries(data: data)

            // TODO: Move to better place
            let filteredNetworkLogs = self.prepareNetworkLogs(data: data)
            self.networkViewModel.addNewEntries(data: filteredNetworkLogs)
        }
    }

    func loadExistedJSON(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }

                if let data = data,
                   let result = self.convertDataToArray(data: data) {
                    self.addNewEntries(data: result)
                }
            }
        }.resume()
    }

    func prepareNetworkLogs(data: [[String: AnyObject]]) -> [[String: AnyObject]] {
        data.filter {
            guard let subsystem = $0["subsystem"] as? String,
                  subsystem.contains("/native_application/network_requests") else {
                return false
            }
            return true
        }
    }
}
