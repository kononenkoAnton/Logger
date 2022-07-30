//
//  StoragesRecordModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

struct StoragesRecordModel: Identifiable {
    let id = UUID()
    let key: String
    let value: String
}
