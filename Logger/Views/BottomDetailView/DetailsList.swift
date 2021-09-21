//
//  DetailsList.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct DetailsList: View {
    let items: [DataModel]
    var body: some View {
        List(items, children: \.items) { row in
            Text(createTitle(row: row)).font(.headline)
        }
    }

    func createTitle(row: DataModel) -> String {
        var message = "\(row.key)"
        if let value = row.value {
            message = "\(message) - '\(value)'"
        }
        return message
    }
}

struct DetailsList_Previews: PreviewProvider {
    static var previews: some View {
        let numbers = [DataModel(key: "1"), DataModel(key: "2"), DataModel(key: "3")]
        let data = DataModel(key: "Data", items: [
            DataModel(key: "A", items: numbers),
            DataModel(key: "B", items: numbers),
            DataModel(key: "C", items: numbers),
        ])
        let context = DataModel(key: "Context", items: [
            DataModel(key: "A", items: numbers),
            DataModel(key: "B", items: numbers),
            DataModel(key: "C", items: numbers),
        ])
        DetailsList(items: [data, context])
    }
}
