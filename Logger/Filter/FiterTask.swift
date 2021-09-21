//
//  FiterTask.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation


class FilterTask{
    init(filterObject:Any,
         filterAction:@escaping ([EventModel], Any)->[EventModel],
         otherFilter:FilterTask? = nil)
         {
        self.filterObject = filterObject
        self.filterAction = filterAction
        self.otherFilter = otherFilter
    }
    var otherFilter: FilterTask?
        
    var filterObject: Any
    var filterAction: ([EventModel], Any)->[EventModel]
    
    func filter(data: [EventModel]) -> [EventModel] {
        let filteredData = filterAction(data, filterObject)
        guard let otherFilter = otherFilter else {
            return filteredData
        }
        return otherFilter.filter(data: filteredData)
    }
}
