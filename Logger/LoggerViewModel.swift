//
//  LoggerViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import AppKit
import Foundation

class LoggerViewModel: ObservableObject {
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
        guard let data = notification.object as? [String: Any] else {
            return
        }
        DispatchQueue.main.async {
            //TODO: Add sync
            let newEvent = EventModel.create(from: data)
            self.loggerModel.addNewItem(model: newEvent)
        }
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
        let result = "http://\(getIPAddress()):9080/postEvent`"
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
