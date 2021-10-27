//
//  EventModel+.Networking.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import Foundation

extension EventModel {
    struct EventModelStatusCodeKeys {
        static let statusCode = "statusCode"
    }

    var networkStatusCode: NetworkRequestStatusCode {
        guard let statusCodeString = self.networkRequestStatusCode,
              let networkRequestStatusCode = NetworkRequestStatusCode(statusCode: statusCodeString) else {
            return NetworkRequestStatusCode.x200
        }
        return networkRequestStatusCode
    }

    var httpStatusCodeDescription: HTTPStatusCode? {
        guard let statusCodeString = self.networkRequestStatusCode,
              let httpStatusCode = HTTPStatusCode(rawValue: Int(statusCodeString) ?? 0) else {
            return nil
        }
        return httpStatusCode
    }

    public var networkRequestStatusCode: String? {
        return data?[EventModelStatusCodeKeys.statusCode] as? String
    }
}
