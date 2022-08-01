//
//  StoragestTableView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragestTableView: View {
    @ObservedObject var storagesViewModel: StoragesViewModel
    @State private var selection: DataModel.ID?

    var body: some View {
        List(storagesViewModel.filteredRecords, children: \.items) { row in
            Text(createTitle(row: row))
                .foregroundColor(Color(ColorKeys.BottomDetailedViewFont)).font(.headline)
                .textSelection(.enabled)
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

// struct StoragestTableView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragestTableView()
//    }
// }

//        Table(eventModels, selection: $selection) {
//            TableColumn("Key", value: \.key).width(min: 300, ideal: 300, max: 300)
//
//            TableColumn("Value", value: \.value!)
//        }
