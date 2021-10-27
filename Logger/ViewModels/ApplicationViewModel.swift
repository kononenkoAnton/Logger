//
//  ApplicationViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import AppKit
import Foundation

class ApplicationViewModel: ObservableObject {
    struct EndPoints {
        static let PostEvent = "postEvent"
        static let PostBatchEvents = "postBatchEvents"
    }

    @Published var loggerViewModel = LoggerViewModel()
    @Published var networkViewModel = NetworkViewModel()

    @Published var sideMenuViewModel = SideMenuViewModel()
    var localServer = LocalSever()

    init() {
        let strIPAddress: String = getIPAddress()
        NotificationCenter.default.addObserver(self, selector: #selector(populateRemoteData(_:)), name: NSNotification.Name("PostEvent"), object: nil)
        localServer.startLocalServer()
        searchBarFilterData = UserDefaultManager.getSearchBarData()
        updateLoggersFilterData()
        print("IPAddress : \(strIPAddress)")
    }

    deinit {
        localServer.stopLocalServer()
    }

    @objc func populateRemoteData(_ notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let data = notification.object as? [[String: AnyObject]] else {
                return
            }
            self.addNewEntries(data: data)
        }
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

    func updateLoggersFilterData() {
        loggerViewModel.searchBarFilterData = searchBarFilterData
        networkViewModel.searchBarFilterData = searchBarFilterData
    }

    // MARK: - Intents(s)

    var searchBarFilterData: String? {
        didSet {
            if let trimmedString = searchBarFilterData?.trimmingCharacters(in: .whitespacesAndNewlines),
               trimmedString.count > 0 {
                UserDefaultManager.saveSearchBar(data: trimmedString)
            } else {
                UserDefaultManager.saveSearchBar(data: nil)
                searchBarFilterData = nil
            }

            updateLoggersFilterData()
        }
    }

    func filteredEvents() -> [EventModel] {
        switch sideMenuViewModel.selectedData.screenType {
        case .logger:
            return loggerViewModel.filteredEvents
        case .networkLogger:
            return networkViewModel.filteredEvents
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
        loggerViewModel.clearLoggerData()
        networkViewModel.clearLoggerData()
    }

    func addNewEntries(data: [[String: AnyObject]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.loggerViewModel.addNewEntries(data: data)

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
