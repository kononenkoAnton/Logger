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
        static let SearchBar = "SearchBar"
        static let StorageType = "StorageType"
    }

    // MARK: - Storage Type

    static func saveStorageType(type: StoragesType) {
        UserDefaults.standard.set(type.rawValue,
                                  forKey: Keys.StorageType)
    }

    static func getStorageType() -> StoragesType {
        let storageTypeInt = UserDefaults.standard.integer(forKey: Keys.StorageType)
        guard let type = StoragesType(rawValue: storageTypeInt) else {
            return .local
        }
        return type
    }

    // MARK: - Log type

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

    // MARK: - Logger Search Bar

    static func saveSearchBar(data: String?) {
        if data == nil {
            UserDefaults.standard.removeObject(forKey: Keys.SearchBar)
            return
        }

        UserDefaults.standard.set(data,
                                  forKey: Keys.SearchBar)
    }

    static func getSearchBarData() -> String? {
        return UserDefaults.standard.string(forKey: Keys.SearchBar)
    }
}
