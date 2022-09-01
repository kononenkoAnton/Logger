//
//  FilterManager.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

struct FilterManager {
    func filterData(data: [EventModel],
                    logLevel: LogLevel,
                    searchBarData: String?) -> [EventModel] {
        let task = FilterTask(filterObject: logLevel,
                              filterAction: filterByLogLevel)
        if let searchBarData = searchBarData {
            let secondTask = FilterTask(filterObject: searchBarData,
                                        filterAction: filterBySearchBarData)
            task.otherFilter = secondTask
        }
        return task.filter(data: data)
    }

    func filterByLogLevel(data: [EventModel],
                          filterObject: Any) -> [EventModel] {
        guard let filterObject = filterObject as? LogLevel else {
            return data
        }
        switch filterObject {
        case .error:
            return data.filter({$0.level.rawValue == LogLevel.error.rawValue})
        case .warning:
            return data.filter({$0.level.rawValue >= LogLevel.warning.rawValue})
        case .info:
            return data.filter({$0.level.rawValue >= LogLevel.info.rawValue})
        case .debug:
            return data.filter({$0.level.rawValue >= LogLevel.debug.rawValue})
        case .verbose:
            return data
        }
    }

    func filterBySearchBarData(data: [EventModel],
                               filterText: Any) -> [EventModel] {
        guard let filterText = filterText as? String else {
            return data
        }
        let lowercasedFilteredText = filterText.lowercased()
        return data.filter { (event) -> Bool in
            event.subsystem.lowercased().contains(lowercasedFilteredText) ||
                event.category.lowercased().contains(lowercasedFilteredText) ||
                event.message.lowercased().contains(lowercasedFilteredText)
        }
    }
}
