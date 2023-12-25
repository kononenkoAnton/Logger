//
//  StorageDataModel.swift
//  Logger
//
//  Created by Anton Kononenko on 8/1/22.
//

struct StoragesDataModel {
    typealias StorageData = [String: [String: String]]
    struct ParsingKeys {
        static let session = "session"
        static let local = "local"
        static let secure = "secure"
        
        struct Xstr {
            static let session = "session"
            static let local = "local"
            static let keychain = "keychain"
            static let storages = "storages"
        }
    }

    let session: [DataModel]
    let local: [DataModel]
    let secure: [DataModel]

    static func create(from object: [String: Any]) -> StoragesDataModel {
        guard let sessionDict = object[ParsingKeys.session] as? [String: Any],
              let localDict = object[ParsingKeys.local] as? [String: Any],
              let secureDict = object[ParsingKeys.secure] as? [String: Any] else {
            return StoragesDataModel(session: [], local: [], secure: [])
        }
        
        let session = createModel(sessionDict)
        let local = createModel(localDict)
        let secure = createModel(secureDict)
        return StoragesDataModel(session: session, local: local, secure: secure)
    }

    static func createModel(_ data: [String: Any]) -> [DataModel] {
        let records: [DataModel] = DataModelHelper.prepareDataSourceDictionary(dataDicionary: data)

        return records
    }
}
