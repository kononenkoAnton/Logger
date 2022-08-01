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
    }

    let session: [DataModel]
    let local: [DataModel]
    let secure: [DataModel]

    static func create(from object: [String: Any]) -> StoragesDataModel {
        let sessionDict = object[ParsingKeys.session] as! [String: Any]
        let session = createModel(sessionDict)

        let localDict = object[ParsingKeys.local] as! [String: Any]
        let local = createModel(localDict)

        let secureDict = object[ParsingKeys.secure] as! [String: Any]
        let secure = createModel(secureDict)

        return StoragesDataModel(session: session, local: local, secure: secure)
    }

    static func createModel(_ data: [String: Any]) -> [DataModel] {
        let records: [DataModel] = DataModelHelper.prepareDataSourceDictionary(dataDicionary: data)

        return records
    }
}
