//
//  DetailsList.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct DetailSectionHeader: View {
    var body: some View {
        VStack {
            Text("FOO")
        }.frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading).background(Color.gray)
    }
}

struct NetworkDetailsList: View {
    let items: [DataModel]

    init(items: [DataModel]) {
        self.items = items
    }

    var body: some View {
        VStack {
            List(items, children: \.items) { row in
                Text(createTitle(row: row))
                    .foregroundColor(Color(ColorKeys.BottomDetailedViewFont)).font(.headline)
            }
            .setBackgroundColor(color: NSColor(named: ColorKeys.BackgroundDetailListColor)!)
            .padding()
        }.frame(maxWidth: .infinity)
    }

    func createTitle(row: DataModel) -> String {
        var message = "\(row.key)"
        if let value = row.value {
            message = "\(message) - '\(value)'"
        }
        return message
    }
}

struct NetworkDetailsList_Previews: PreviewProvider {
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
