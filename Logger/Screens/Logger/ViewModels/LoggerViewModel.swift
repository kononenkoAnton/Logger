//
//  LoggerViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import AppKit
import Foundation

class LoggerViewModel: ObservableObject, FilteredDataProtocol {

    @Published var loggerModel: LoggerModel
    @Published var filteredEvents: [EventModel] = []
    @Published var socketConnectionIndicator: LocalWebSocket.Status = .notConnected

    private var wasFiltered = false

    init() {
        let strIPAddress: String = getIPAddress()
        loggerModel = LoggerModel()
        loggerModel.eventsDidUpdate = eventsDidUpdate
        prepareFilteredData()

        print("IPAddress : \(strIPAddress)")
        NotificationManager.shared.addObserver(observer: self,
                                               to: Notification.Name.PostLogEvent)
        NotificationManager.shared.addObserver(observer: self,
                                               to: Notification.Name.SocketStatusDidUpdate)
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
        let newEvents = data.map { EventModel.create(from: $0) }
        loggerModel.addNewItems(models: newEvents)
    }

    func parseCurrentVisibleDataToJSONFileDocument() -> JSONFileDocument? {
        return DataModelHelper.parseEventsToJSONFileDocument(events: filteredEvents)
    }

    func getExportDefaultName() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY.MM.dd"
        let stringDate = dateFormatter.string(from: date)
        return "your_app_name_\(stringDate)"
    }

    func loadExistedJSON(url: URL) {
        clearLoggerData()

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                if let data = data,
                   let convertedData = self.convertDataToArray(data: data) {
                    self.addNewEntries(data: convertedData)
                    self.loggerModel.sortByTimeStamp()
                }
            }
        }.resume()
    }

    func convertDataToArray(data: Data) -> [[String: AnyObject]]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let array = json as? [[String: AnyObject]] {
                return array
            } else if let singleObject = json as? [String: AnyObject] {
                return [singleObject]
            }
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
        let result = "ws://\(getIPAddress()):9080"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string],
                                owner: nil)
        pasteboard.setString(result, forType: NSPasteboard.PasteboardType.string)
    }

    func dataModels(from model: EventModel) -> [DataModel] {
        return DataModelHelper.prepareDataSource(from: model)
    }

    func selectModelById(id: EventModel.ID?) {
        guard let id = id else { return }
        let model = filteredEvents.first { $0.id == id }
        if let model = model {
            setModelSelected(model: model)
        }
    }

    func setModelSelected(model: EventModel) {
        loggerModel.setSelectedModel(model: model)
    }

    func getModelSelected() -> EventModel? {
        loggerModel.selectedModel
    }

    func sendConsoleCommand(_ command: String) {
        try? LoggerAppManager.shared.sendCommandToClient(command)
    }

    func sendConsoleCommandShareCommandsLikst() {
        try? LoggerAppManager.shared.sendCommandToClient("cmdlist")
    }
}

extension LoggerViewModel: DataSourceCountableProtocol {
    func getEventsCount() -> Int {
        return events().count
    }
}

extension LoggerViewModel: NotificationObserver {
    func notificationDidReceived(key: NotificationManager.NotificationEvenName, data: Any?) {
        switch key {
        case NotificationManager.NotificationEvenName.PostLogEvent:
            addNewEntries(data: data)
        case NotificationManager.NotificationEvenName.SocketStatusDidUpdate:
            socketStatusDidUpdate(data: data)
        default:
            break
        }
    }

    func addNewEntries(data: Any?) {
        guard let data = data as? [[String: AnyObject]] else {
            return
        }

        addNewEntries(data: data)
    }

    func socketStatusDidUpdate(data: Any?) {
        guard let status = data as? LocalWebSocket.Status else {
            print("socketStatusDidUpdate: Something went wrong")
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.socketConnectionIndicator = status
        }
    }
}
