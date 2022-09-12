//
//  EventModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import Foundation


struct EventModel: Identifiable, Equatable {
    struct ParsingKeys {
        static let category = "category"
        static let subsystem = "subsystem"
        static let timestamp = "timestamp"
        static let level = "level"
        static let message = "message"
        static let data = "data"
        static let context = "context"
    }
    
    let dateFormatter = DateFormatter()
    public var format = "yyyy-MM-dd HH:mm:ss.SSS"

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
    
    func toOject() -> [String: Any] {
        return [
            ParsingKeys.category : category as Any,
            ParsingKeys.subsystem : subsystem as Any,
            ParsingKeys.timestamp : timestamp as Any,
            ParsingKeys.level : level.rawValue as Any,
            ParsingKeys.message : message as Any,
            ParsingKeys.data : data as Any,
            ParsingKeys.context : context as Any,
        ]
    }

    static func create(from object: [String: Any]) -> EventModel {
        let category = object[ParsingKeys.category] as! String
        let subsystem = object[ParsingKeys.subsystem] as! String
        let timestamp = object[ParsingKeys.timestamp] as! UInt
        let level = LogLevel(rawValue: object[ParsingKeys.level] as! Int)!
        let message = object[ParsingKeys.message] as! String
        let data = object[ParsingKeys.data] as? [String: Any]
        let context = object[ParsingKeys.context] as? [String: Any]
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
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        let date = Date(timeIntervalSince1970: TimeInterval(Double(timestamp)/1000))
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
