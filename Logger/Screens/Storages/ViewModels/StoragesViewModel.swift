//
//  StoragesViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

class StoragesViewModel: ObservableObject, FilteredDataProtocol {
    var storagesDataModel: StoragesDataModel?

    @Published var filteredRecords: [DataModel] = []
    private var wasFiltered = false

    init() {
        NotificationManager.shared.addObserver(observer: self,
                                               to: Notification.Name.PostStorageEvents)
    }

    // MARK: - Intents(s)

    func reloadStorages() {
        do {
            try LoggerAppManager.shared.sendCommandToClient("storage.list")
        } catch {
            print("reloadStorages: \(error)")
        }
    }

    func storageData() -> [DataModel] {
        return filteredRecords
    }

    var storageType = UserDefaultManager.getStorageType() {
        didSet {
            UserDefaultManager.saveStorageType(type: storageType)
            prepareFilteredData()
        }
    }

    var searchBarFilterData = UserDefaultManager.getStorageSearchBarData() {
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

    func addNewRecord() {
        // TODO: Pass command
    }

    func getExportDefaultName() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY.MM.dd"
        let stringDate = dateFormatter.string(from: date)
        return "your_app_name_\(stringDate)"
    }

    func eventsDidUpdate() {
        wasFiltered = false
    }

    private func prepareFilteredData() {
        // TODO: Implement
//        let manager = FilterManager()
//        let result = manager.filterData(data: loggerModel.events,
//                                        logLevel: logLevel,
//                                        searchBarData: searchBarFilterData)
        switch storageType {
        case .local:
            if let local = storagesDataModel?.local {
                filteredRecords = local
            }

        case .session:
            if let session = storagesDataModel?.session {
                filteredRecords = session
            }
        case .keychain:
            if let keychain = storagesDataModel?.secure {
                filteredRecords = keychain
            }
        }

        wasFiltered = true
    }

    func loadExistedJSON(url: URL) {
        clearStoragesData()

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                parseLoadedData(data)
            }
        }.resume()
    }

    func parseLoadedData(_ data: Data?) {
        guard let data,
              let convertedData = convertDataToArray(data: data),
              let content = getContent(from: convertedData, withSingleObject: StoragesDataModel.ParsingKeys.Xstr.storages) else {
            return
        }
        parseEvents(from: content)
    }

    func clearStoragesData() {
        storagesDataModel = StoragesDataModel.create(from: [:])
        prepareFilteredData()
    }

    func parseEvents(from content: [String: AnyObject]) {
        storagesDataModel = StoragesDataModel.create(from: content)
        prepareFilteredData()
    }

    func convertDataToArray(data: Data) -> [String: AnyObject]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let object = json as? [String: AnyObject] {
                return object
            }
        } catch {
            print("Something went wrong")
        }
        return nil
    }

    func getContent(from data: [String: AnyObject]?, withSingleObject key: String) -> [String: AnyObject]? {
        guard let storages = data?[key] as? [String: Any] else {
            return nil
        }

        let local = storages[StoragesDataModel.ParsingKeys.Xstr.local] as? [String: Any] ?? [:]
        let session = storages[StoragesDataModel.ParsingKeys.Xstr.session] as? [String: Any] ?? [:]
        let keychain = storages[StoragesDataModel.ParsingKeys.Xstr.keychain] as? [String: Any] ?? [:]

        return [StoragesDataModel.ParsingKeys.local: local as AnyObject,
                StoragesDataModel.ParsingKeys.session: session as AnyObject,
                StoragesDataModel.ParsingKeys.secure: keychain as AnyObject]
    }
}

extension StoragesViewModel: DataSourceCountableProtocol {
    func getEventsCount() -> Int {
        filteredRecords.count
    }
}

extension StoragesViewModel: NotificationObserver {
    func notificationDidReceived(key: NotificationManager.NotificationEvenName, data: Any?) {
        guard let data = data as? [String: AnyObject] else {
            return
        }
        parseEvents(from: data)
    }
}
