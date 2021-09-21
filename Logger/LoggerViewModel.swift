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

    init() {
        let strIPAddress: String = getIPAddress()
        print("IPAddress : \(strIPAddress)")
    }

    // MARK: - Intents(s)

    var logLevel = UserDefaultManager.getLogLevel() {
        didSet {
            UserDefaultManager.saveLog(level: logLevel)
        }
    }

    var searchBarFilterData = UserDefaultManager.getSearchBarData() {
        didSet {
            UserDefaultManager.saveSearchBar(data: searchBarFilterData)
        }
    }

    func clearLoggerData() {
        loggerModel.clearLoggerData()
        loggerModel.setSelectedModel(model: nil)
    }

    func events() -> [EventModel] {
        loggerModel.events
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
        objectWillChange.send()
    }

    func getModelSelected() -> EventModel? {
        loggerModel.selectedModel
    }
}
