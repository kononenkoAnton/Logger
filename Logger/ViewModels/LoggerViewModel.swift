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

    init() {
        loggerModel = LoggerModel(id: "LoggerModel")
        prepareFilteredData()
    }

    // MARK: - Intents(s)

    var logLevel = UserDefaultManager.getLogLevel() {
        didSet {
            UserDefaultManager.saveLog(level: logLevel)
            prepareFilteredData()
        }
    }

    var searchBarFilterData = UserDefaultManager.getSearchBarDataLogger() {
        didSet {
            if let trimmedString = searchBarFilterData?.trimmingCharacters(in: .whitespacesAndNewlines),
               trimmedString.count > 0 {
                UserDefaultManager.saveSearchBarLogger(data: trimmedString)
            } else {
                UserDefaultManager.saveSearchBarLogger(data: nil)
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
            self.prepareFilteredData()
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

    private func prepareFilteredData() {
        let manager = FilterManager()
        let result = manager.filterData(data: loggerModel.events,
                                        logLevel: logLevel,
                                        searchBarData: searchBarFilterData)
        filteredEvents = result
    }

    func events() -> [EventModel] {
        return filteredEvents
    }

    func copyIpAdress() {
        let result = "http://\(getIPAddress()):9080/\(EndPoints.PostBatchEvents)"
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
