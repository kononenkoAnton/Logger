//
//  LogEventRow.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct LogEventRow: View {
    var model: EventModel

    var backgroundColor: Color
    var body: some View {
        GeometryReader { _ in
            HStack {
                Circle().frame(width: 10).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 55)).foregroundColor(model.level.toColor())
                Text(model.dateInString).frame(width: 200, alignment: .leading).padding(.horizontal, 10)
                Text(model.category).frame(width: 350, alignment: .leading).padding(EdgeInsets(top: 0, leading: 22, bottom: 0, trailing: 10))
                Text(model.subsystem).frame(width: 500, alignment: .leading).padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 10))
                Text(model.message).frame(alignment: .leading).padding(EdgeInsets(top: 0, leading: 21, bottom: 0, trailing: 10))
            }.frame(alignment: .leading)
        }.frame(height: 25).background(backgroundColor)
    }
}

struct LogEventRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        LogEventRow(model: model, backgroundColor: Color.gray)
    }
}
