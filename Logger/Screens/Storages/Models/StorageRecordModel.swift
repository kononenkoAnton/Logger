//
//  StorageRecordModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

struct StorageNameSpaceModel: Identifiable {
    let id = UUID()
    let namespace: String
    let records: [StorageRecordModel]
}

struct StorageRecordModel: Identifiable {
    let id = UUID()
    let key: String
    let value: String
}
