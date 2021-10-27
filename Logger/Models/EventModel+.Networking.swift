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

    var method: String {
        guard let request = self.data?["request"] as? [String: Any],
              let method = request["method"] as? String else {
            return ""
        }
        return method
    }

    var url: String {
        guard let url = self.data?["url"] as? String else {
            return "Can not find url, please check logs data"
        }
        return url
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
