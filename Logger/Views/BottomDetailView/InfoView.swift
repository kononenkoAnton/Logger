//
//  InfoView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct InfoView: View {
    var model: EventModel
    var body: some View {
        HStack {
            VStack {
                InfoViewLabel(title: "Category:", description: model.category)
                InfoViewLabel(title: "Subsystem:", description: model.subsystem)
                InfoViewLabel(title: "Message:", description: model.message)
            }.frame(alignment: .leading)
            VStack {
                HStack {
                    Spacer()
                    Text("Level:")
                    LogTypeView(logType: model.level.toString(),
                                color: model.level.toColor())
                }
                HStack {
                    Spacer()
                    Text(model.dateInString)
                }
            }.frame(width:200)
        }.frame(height: 80).padding(20)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        InfoView(model: model)
    }
}
