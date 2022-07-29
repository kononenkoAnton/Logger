//
//  StoragesViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

class StoragesViewModel: ObservableObject, FilteredDataProtocol {
    var searchBarFilterData: String? // TODO: Add data from defaults
    
    // MARK: - Intents(s)

    func prepareFilteredData() {
        //TODO: Prepare data source
    }
    
    var storageType = UserDefaultManager.getStorageType() {
        didSet {
            UserDefaultManager.saveStorageType(type: storageType)
            prepareFilteredData()
        }
    }

}

extension StoragesViewModel: DataSourceCountableProtocol {
    func getEventsCount() -> Int {
        0
    }
}
