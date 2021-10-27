//
//  NetworkViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import Foundation

class NetworkViewModel: ObservableObject {
    @Published var loggerModel: LoggerModel = LoggerModel(id: "NetworkModel")
    @Published var filteredEvents: [EventModel] = []

    // MARK: - Intents(s)

    var statusCode = UserDefaultManager.getLogStatusCode() {
        didSet {
            UserDefaultManager.saveLog(statusCode: statusCode)
            prepareFilteredData()
        }
    }

    var searchBarFilterData:String? {
        didSet {
            prepareFilteredData()
        }
    }

    func clearLoggerData() {
        loggerModel.clearLoggerData()
        loggerModel.setSelectedModel(model: nil)
        prepareFilteredData()
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
                                        statusCode: statusCode,
                                        searchBarData: searchBarFilterData)
        filteredEvents = result
    }

    func events() -> [EventModel] {
        return filteredEvents
    }

    func dataModels(from model: EventModel) -> [DataModel] {
        return DataModelHelper.prepareDataSource(from: model)
    }

    func setModelSelected(model: EventModel) {
        loggerModel.setSelectedModel(model: model)
    }

    func getModelSelected() -> EventModel? {
        loggerModel.selectedModel
    }
}
