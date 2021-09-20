//
//  EventModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import Foundation
struct EventModel {
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

    public let id: String
    public let category: String
    public let subsystem: String
    public let timestamp: UInt // UTC
    public let level: LogLevel
    public let message: String
    public let data: [String: Any]?
    public let context: [String: Any]?
    public var dateInString: String {
        return "\(timestamp)"
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
