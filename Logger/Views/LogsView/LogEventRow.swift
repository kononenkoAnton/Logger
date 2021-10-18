//
//  LogEventRow.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct LogEventRow: View {
    var isSelected: Bool

    var model: EventModel

    var backgroundColor: Color
    var body: some View {
        HStack {
            Circle().frame(width: 10).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 55)).foregroundColor(model.level.toColor())
            Text(model.message).frame(alignment: .leading).padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 10))
            Spacer()
            Text(model.subsystem).truncationMode(.head).lineLimit(1)
                .frame(width: 550, alignment: .leading).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            Text(model.category).frame(width: 200, alignment: .leading).padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 10))
            Text(model.dateInString).frame(width: 200, alignment: .leading).padding(.horizontal, 10)

        }
        .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
            .background(isSelected ? Color.rowBacgroundColorSelected : backgroundColor)
    }
}

struct LogEventRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        LogEventRow(isSelected:false, model: model, backgroundColor: Color.gray)
    }
}
