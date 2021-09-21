//
//  LoggerViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import AppKit
import Foundation

class LoggerViewModel: ObservableObject {
    @Published var loggerModel = LoggerModel()
    @Published var filteredEvents: [EventModel] = []
    init() {
        let strIPAddress: String = getIPAddress()
        prepareFilteredData()

        print("IPAddress : \(strIPAddress)")
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
            UserDefaultManager.saveSearchBar(data: searchBarFilterData)
            prepareFilteredData()

        }
    }

    func clearLoggerData() {
        loggerModel.clearLoggerData()
        loggerModel.setSelectedModel(model: nil)
    }

    private func prepareFilteredData(){
        let manager = FilterManager()
        let result = manager.filterData(data: loggerModel.events,
                                  logLevel: logLevel,
                                  searchBarData: searchBarFilterData)
        filteredEvents = result
        
    }
    
    func events() -> [EventModel] {
//        prepareFilteredData()
        return filteredEvents
    }

    func copyIpAdress() {
        let result = "http://\(getIPAddress()):9080"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
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
