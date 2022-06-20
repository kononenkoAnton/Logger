//
//  DataModelHelper.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

struct DataModelHelper {
    static func prepareDataSource(from model: EventModel) -> [DataModel] {
        let data = model.data
        let context = model.context
        var retVal: [DataModel] = []

        if let data = data {
            let dataObjectArray = prepareDataSourceDictionary(dataDicionary: data)
            let dataObject = DataModel(key: "Data", items: dataObjectArray)
            if dataObjectArray.count > 0 {
                retVal.append(dataObject)
            }
        }

        if let context = context {
            let contextObjectArray = prepareDataSourceDictionary(dataDicionary: context)
            let contextObject = DataModel(key: "Context", items: contextObjectArray)
            if contextObjectArray.count > 0 {
                retVal.append(contextObject)
            }
        }

        return retVal
    }

    static func prepareDataSourceDictionary(dataDicionary: [String: Any]) -> [DataModel] {
        var newDataSource: [DataModel] = []
        let noDataText = "No data availible"

        for (key, value) in dataDicionary {
            if let value = value as? [Any] {
                let dataModel = DataModel(key: key, items: prepareDataSourceArray(dataArray: value))
                newDataSource.append(dataModel)
            } else if let value = value as? [String: Any] {
                let dataModel = DataModel(key: key, items: prepareDataSourceDictionary(dataDicionary: value))
                newDataSource.append(dataModel)
            } else if let value = value as? String {
                let newValue = value.count > 0 ? value : noDataText
                let dataModel = DataModel(key: key, value: newValue)
                newDataSource.append(dataModel)
            } else if let value = value as? NSNumber {
                let stringValue = value.stringValue
                let newValue = stringValue.count > 0 ? stringValue : noDataText
                let dataModel = DataModel(key: key, value: newValue)
                newDataSource.append(dataModel)
            }
        }
        return newDataSource
    }

    static func prepareDataSourceArray(dataArray: [Any]) -> [DataModel] {
        var newDataSource: [DataModel] = []
        let noDataText = "No data availible"

        for value in dataArray {
            if let value = value as? [Any] {
                let newKey = "Items: \(value.count)"
                let dataModel = DataModel(key: newKey, items: prepareDataSourceArray(dataArray: value))
                newDataSource.append(dataModel)
            } else if let value = value as? [String: Any] {
                let newKey = "Items: \(value.keys.count)"
                let dataModel = DataModel(key: newKey, items: prepareDataSourceDictionary(dataDicionary: value))
                newDataSource.append(dataModel)
            } else if let value = value as? String {
                let newKey = value.count > 0 ? value : noDataText
                let dataModel = DataModel(key: newKey)
                newDataSource.append(dataModel)

            } else if let value = value as? NSNumber {
                let stringValue = value.stringValue
                let newKey = stringValue.count > 0 ? stringValue : noDataText
                let dataModel = DataModel(key: newKey)
                newDataSource.append(dataModel)
            }
        }
        return newDataSource
    }

    static func quickSortByTimestamp(eventModelsArray: [EventModel]) -> [EventModel] {
        if eventModelsArray.count < 2 {
            // base case, arrays with 0 or 1 element are already "sorted"
            return eventModelsArray
        } else {
            // recursive case
            let pivot = eventModelsArray[eventModelsArray.count / 2].timestamp

            // sub-array of all the elements less than the pivot
            let less = eventModelsArray.filter { $0.timestamp < pivot }

            // sub-array of all the elements equal to the pivot
            let equal = eventModelsArray.filter { $0.timestamp == pivot }

            // sub-array of all the elements greater than the pivot
            let greater = eventModelsArray.filter { $0.timestamp > pivot }

            return quickSortByTimestamp(eventModelsArray: less) + equal + quickSortByTimestamp(eventModelsArray: greater)
        }
    }

    private static func arrayOfEventsToObjects(_ events: [EventModel]) -> [[String: Any]] {
        events.map { $0.toOject() }
    }

    private static func objectsToData(_ eventOfObjects: [[String: Any]]) -> Data? {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: eventOfObjects, options: [])
            return jsonData
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }

        return nil
    }

    static func parseEventsToJSONFileDocument(events: [EventModel]) -> JSONFileDocument? {
        let eventOfObjects = arrayOfEventsToObjects(events)
        guard let jsonData = objectsToData(eventOfObjects) else {
            return nil
        }
        return JSONFileDocument(jsonData: jsonData)
    }
}
