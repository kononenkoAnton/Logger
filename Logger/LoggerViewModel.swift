//
//  LoggerViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import AppKit
import Foundation

class LoggerViewModel: ObservableObject {
    struct EndPoints {
        static let PostEvent = "postEvent"
        static let PostBatchEvents = "postBatchEvents"
    }

    @Published var loggerModel: LoggerModel
    @Published var filteredEvents: [EventModel] = []
    var wasFiltered = false
    var localServer = LocalSever()

    init() {
        let strIPAddress: String = getIPAddress()
        loggerModel = LoggerModel()
        loggerModel.eventsDidUpdate = eventsDidUpdate
        prepareFilteredData()
        localServer.startLocalServer()
        print("IPAddress : \(strIPAddress)")

        NotificationCenter.default.addObserver(self, selector: #selector(receiveTest(_:)), name: NSNotification.Name("PostEvent"), object: nil)
    }

    @objc func receiveTest(_ notification: NSNotification) {
        guard let data = notification.object as? [[String: AnyObject]] else {
            return
        }
        addNewEntries(data: data)
    }

    deinit {
        localServer.stopLocalServer()
    }

    // MARK: - Intents(s)

    var logLevel = UserDefaultManager.getLogLevel() {
        didSet {
            UserDefaultManager.saveLog(level: logLevel)
            prepareFilteredData()
        }
    }

    var searchBarFilterData = UserDefaultManager.getSearchBarData() {
        didSet {
            if let trimmedString = searchBarFilterData?.trimmingCharacters(in: .whitespacesAndNewlines),
               trimmedString.count > 0 {
                UserDefaultManager.saveSearchBar(data: trimmedString)
            } else {
                UserDefaultManager.saveSearchBar(data: nil)
                searchBarFilterData = nil
            }
            prepareFilteredData()
        }
    }

    func clearLoggerData() {
        loggerModel.clearLoggerData()
        loggerModel.setSelectedModel(model: nil)
    }

    func addNewEntries(data: [[String: AnyObject]]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let newEvents = data.map { EventModel.create(from: $0) }
            self.loggerModel.addNewItems(models: newEvents)
        }
    }

    func loadExistedJSON(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
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

    func convertDataToArray(data: Data) -> [[String: AnyObject]]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]]
            return json
        } catch {
            print("Something went wrong")
        }
        return nil
    }

    func eventsDidUpdate() {
        wasFiltered = false
    }

    private func prepareFilteredData() {
        let manager = FilterManager()
        let result = manager.filterData(data: loggerModel.events,
                                        logLevel: logLevel,
                                        searchBarData: searchBarFilterData)
        wasFiltered = true
        filteredEvents = result
    }

    func events() -> [EventModel] {
        if wasFiltered == false {
            prepareFilteredData()
        }
        return filteredEvents
    }

    func copyIpAdress() {
        let result = "\(getIPAddress()):9080"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string],
                                owner: nil)
        pasteboard.setString(result, forType: NSPasteboard.PasteboardType.string)
    }

    func dataModels(from model: EventModel) -> [DataModel] {
        print("model", model)

        return DataModelHelper.prepareDataSource(from: model)
    }

    func setModelSelected(model: EventModel) {
        loggerModel.setSelectedModel(model: model)
    }

    func getModelSelected() -> EventModel? {
        loggerModel.selectedModel
    }
}
