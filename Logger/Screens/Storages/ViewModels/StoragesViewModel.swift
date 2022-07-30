//
//  StoragesViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

class StoragesViewModel: ObservableObject, FilteredDataProtocol {
    var storageEventModel: EventModel?

    @Published var filteredRecords: [StoragesRecordModel] = []
    private var wasFiltered = false

    init() {
        prepareFilteredData()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveData(_:)), name: NSNotification.Name("PostStorageEvent"), object: nil)
    }

    @objc func receiveData(_ notification: NSNotification) {
        guard let data = notification.object as? [String: AnyObject] else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.storageEventModel = EventModel.create(from: data)
        }
    }

    // MARK: - Intents(s)

    func storageData() -> [StoragesRecordModel] {
        return []
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
        //TODO: Pass command
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
//        wasFiltered = true
//        filteredEvents = result
    }

}

extension StoragesViewModel: DataSourceCountableProtocol {
    func getEventsCount() -> Int {
        filteredRecords.count
    }
}
