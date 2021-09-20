//
//  DataModelHelper.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

struct DataModelHelper {
    static func prepareDataSource(from model: EventModel) -> [[DataModel]] {
        let data = model.data
        let context = model.data
        var retVal: [[DataModel]] = []

        if let data = data {
            let dataObject = prepareDataSourceDictionary(dataDicionary: data)
            retVal.append(dataObject)
        }

        if let context = context {
            let contextObject = prepareDataSourceDictionary(dataDicionary: context)
            retVal.append(contextObject)
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
}
