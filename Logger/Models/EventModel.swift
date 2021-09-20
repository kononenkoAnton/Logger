//
//  EventModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import Foundation

struct EventModel: Hashable, Decodable {
    init(id: String,
         category: String,
         subsystem: String,
         timeStamp: UInt,
         level: LogLevel,
         message: String,
         data: [String: AnyCodable]?,
         context: [String: AnyCodable]?) {
        self.id = id
        self.category = category
        self.subsystem = subsystem
        timestamp = timeStamp
        self.level = level
        self.message = message
        self.data = data
        self.context = context
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        category = try values.decode(String.self, forKey: .category)
        subsystem = try values.decode(String.self, forKey: .subsystem)
        timestamp = try values.decode(UInt.self, forKey: .timestamp)
        let levelInt = try values.decode(Int.self, forKey: .level)
        level = LogLevel(rawValue: levelInt)!
        message = try values.decode(String.self, forKey: .message)
        data = try values.decode([String: AnyCodable].self,
                                 forKey: .data)
        context = try values.decode([String: AnyCodable].self,
                                    forKey: .context)
        id = "\(timestamp)+\(message)+\(category)+\(subsystem)+\(levelInt)"
    }

    enum CodingKeys: String, CodingKey {
        case category
        case subsystem
        case timestamp
        case level
        case message
        case data
        case context
        case statusCode
    }

    public let id: String
    public let category: String
    public let subsystem: String
    public let timestamp: UInt // UTC
    public let level: LogLevel
    public let message: String
    public let data: [String: AnyCodable]?
    public let context: [String: AnyCodable]?
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
            lhs.message == rhs.message &&
            lhs.data == rhs.data &&
            lhs.context == rhs.context
    }
}
