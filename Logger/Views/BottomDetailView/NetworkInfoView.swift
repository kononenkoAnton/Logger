//
//  InfoView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct NetworkInfoView: View {
    var model: EventModel
    var body: some View {
        HStack {
            VStack {
                InfoViewLabel(title: "Category:", description: model.category)
                InfoViewLabel(title: "Subsystem:", description: model.subsystem)
                InfoViewLabel(title: "URL:", description: model.url)
            }.frame(alignment: .leading)
            VStack {
                HStack {
                    Spacer()
                    Text("\(model.method):")
                        .bold()
                    LogTypeView(logType: model.httpStatusCodeDescription?.description ?? "no code",
                                color: model.networkStatusCode.toColor()).foregroundColor(Color.white)
                }
                HStack {
                    Spacer()
                    Text(model.dateInString)
                }
            }.frame(width: 200)
        }.frame(height: 80).padding(20)
    }
}

struct NetworkInfoView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        NetworkInfoView(model: model)
    }
}
