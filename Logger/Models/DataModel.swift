//
//  DataModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

struct DataModel: Identifiable {
    let id = UUID()
    let key: String
    var value: String?
    var items: [DataModel]?

}

