//
//  LogsTableView.swift
//  Logger
//
//  Created by Anton Kononenko on 6/22/22.
//

import SwiftUI

struct LogsTableView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    @State private var selection: EventModel.ID?
    @State var sortOrder: [KeyPathComparator<EventModel>] = [
        .init(\.dateInString, order: SortOrder.forward)
    ]
    
    var body: some View {
        let eventModels = loggerViewModel.events()
        Table(eventModels, selection: $selection, sortOrder: $sortOrder) {
            TableColumn(" 🐞") { model in
                Circle().frame(width: 10).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 55)).foregroundColor(model.level.toColor())
            }.width(25)
            TableColumn("Message", value: \.message).width(ideal: 700)
            TableColumn("Subsystem", value: \.subsystem).width(min: 300)
            TableColumn("Category", value: \.category).width(min: 200)
            TableColumn("Time", value: \.dateInString).width(180)
        }.onChange(of: selection) { id in
            loggerViewModel.selectModelById(id: id)
        }
//        .onChange(of: sortOrder) { sortOrder in
//            print("SORT ORDER \(sortOrder)")
//        }
//
    }
}

struct LogsTableView_Previews: PreviewProvider {
    static var previews: some View {
        LogsTableView(loggerViewModel: LoggerViewModel())
    }
}
