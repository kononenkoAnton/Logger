//
//  UserDefaultManager.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

struct UserDefaultManager {
    struct Keys {
        static let LogLevelType = "LogLevelType"
        static let NetworkRequestStatusCodeType = "NetworkRequestStatusCode"
        static let SearchBarTypeLogger = "SearchBarLogger"
        static let SearchBarTypeNetwork = "SearchBarNetwork"
    }

    // MARK: NetworkRequestStatusCode
    
    static func saveLog(statusCode: NetworkRequestStatusCode) {
        UserDefaults.standard.set(statusCode.rawValue,
                                  forKey: Keys.NetworkRequestStatusCodeType)
    }

    static func getLogStatusCode() -> NetworkRequestStatusCode {
        let statusCodeInt = UserDefaults.standard.integer(forKey: Keys.NetworkRequestStatusCodeType)
        guard let statusCode = NetworkRequestStatusCode(rawValue: statusCodeInt) else {
            return .x300
        }
        return statusCode
    }

    // MARK: LogLevelType
    
    static func saveLog(level: LogLevel) {
        UserDefaults.standard.set(level.rawValue,
                                  forKey: Keys.LogLevelType)
    }

    static func getLogLevel() -> LogLevel {
        let logLevelInt = UserDefaults.standard.integer(forKey: Keys.LogLevelType)
        guard let level = LogLevel(rawValue: logLevelInt) else {
            return .verbose
        }
        return level
    }

    // MARK: SearchBarTypeLogger

    static func saveSearchBarLogger(data: String?) {
        if data == nil {
            UserDefaults.standard.removeObject(forKey: Keys.SearchBarTypeLogger)
            return
        }

        UserDefaults.standard.set(data,
                                  forKey: Keys.SearchBarTypeLogger)
    }

    static func getSearchBarDataLogger() -> String? {
        return UserDefaults.standard.string(forKey: Keys.SearchBarTypeLogger)
    }
    
    static func saveSearchBarNetwork(data: String?) {
        if data == nil {
            UserDefaults.standard.removeObject(forKey: Keys.SearchBarTypeNetwork)
            return
        }

        UserDefaults.standard.set(data,
                                  forKey: Keys.SearchBarTypeNetwork)
    }

    static func getSearchBarDataNetwork() -> String? {
        return UserDefaults.standard.string(forKey: Keys.SearchBarTypeNetwork)
    }
}
