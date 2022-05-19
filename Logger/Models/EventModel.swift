//
//  EventModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import Foundation
struct EventModel {
    let dateFormatter = DateFormatter()
    public var format = "yyyy-MM-dd HH:mm:ssZ"

    init(id: String,
         category: String,
         subsystem: String,
         timeStamp: UInt,
         level: LogLevel,
         message: String,
         data: [String: Any]?,
         context: [String: Any]?) {
        self.id = id
        self.category = category
        self.subsystem = subsystem
        timestamp = timeStamp
        self.level = level
        self.message = message
        self.data = data
        self.context = context
    }

    static func create(from object: [String: Any]) -> EventModel {
        let category = object["category"] as! String
        let subsystem = object["subsystem"] as! String
        let timestamp = object["timestamp"] as! UInt
        let level = LogLevel(rawValue: object["level"] as! Int)!
        let message = object["message"] as! String
        let data = object["data"] as? [String: Any]
        let context = object["context"] as? [String: Any]
        let id = "\(UUID())"
        return EventModel(id: id,
                          category: category,
                          subsystem: subsystem,
                          timeStamp: timestamp,
                          level: level,
                          message: message,
                          data: data,
                          context: context)
    }

    public let id: String
    public let category: String
    public let subsystem: String
    public let timestamp: UInt // UTC
    public let level: LogLevel
    public let message: String
    public let data: [String: Any]?
    public let context: [String: Any]?
    public var dateInString: String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    static func == (lhs: EventModel,
                    rhs: EventModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.category == rhs.category &&
            lhs.subsystem == rhs.subsystem &&
            lhs.timestamp == rhs.timestamp &&
            lhs.level.rawValue == rhs.level.rawValue &&
            lhs.message == rhs.message
    }
}
