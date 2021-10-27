//
//  LoggerModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import Foundation

struct LoggerModel: Identifiable {
    let id: String
    var selectedModel: EventModel?
    var events: [EventModel] = []

    mutating func addNewItem(model: EventModel) {
        events.append(model)
    }

    mutating func addNewItems(models: [EventModel]) {
        events.append(contentsOf: models)
    }

    mutating func clearLoggerData() {
        events = []
    }

    mutating func setSelectedModel(model: EventModel?) {
        selectedModel = model
    }
}

struct TestModels {
    static let model1 = EventModel(id: "model1", category: "Category1", subsystem: "subsystem", timeStamp: 211244, level: .verbose, message: "My loogger message1", data:
        ["a": [1, 2, 3, 4],
         "b": "12345",
         "c": ["A": "1", "B": "2"]], context: [:])
    static let model2 = EventModel(id: "model2", category: "Category2", subsystem: "subsystem", timeStamp: 211244, level: .info, message: "My loogger message2", data: [:], context: [:])
    static let model3 = EventModel(id: "model3", category: "Category3", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message3", data: [:], context: [:])
    static let model4 = EventModel(id: "model4", category: "Category4", subsystem: "subsystem", timeStamp: 211244, level: .warning, message: "My loogger message4", data: [:], context: [:])
    static let model5 = EventModel(id: "model5", category: "Category5", subsystem: "subsystem", timeStamp: 211244, level: .error, message: "My loogger message5", data: [:], context: [:])
}
