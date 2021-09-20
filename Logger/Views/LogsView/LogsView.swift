//
//  LogsView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import SwiftUI

struct LogsView: View {
    struct TestModels {
        static let model1 = EventModel(id: "model1", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .verbose, message: "My loogger message", data: [:], context: [:])
        static let model2 = EventModel(id: "model2", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .info, message: "My loogger message", data: [:], context: [:])
        static let model3 = EventModel(id: "model3", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        static let model4 = EventModel(id: "model4", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .warning, message: "My loogger message", data: [:], context: [:])
        static let model5 = EventModel(id: "model5", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .error, message: "My loogger message", data: [:], context: [:])
    }

    var body: some View {
        VStack {
//            EventsHeader()
            VSplitView {
                List {
                    Section(header: EventsHeader()) {
                        LazyVStack {
                            LogEventRow(model: TestModels.model1, backgroundColor: Color.rowBacgroundColor1)
                            Spacer(minLength: 0)
                            LogEventRow(model: TestModels.model2, backgroundColor: Color.rowBacgroundColor2)
                            Spacer(minLength: 0)
                            LogEventRow(model: TestModels.model3, backgroundColor: Color.rowBacgroundColor1)
                            Spacer(minLength: 0)

                            LogEventRow(model: TestModels.model4, backgroundColor: Color.rowBacgroundColor2)
                            Spacer(minLength: 0)

                            LogEventRow(model: TestModels.model5, backgroundColor: Color.rowBacgroundColor1)
                        }.background(Color.green)
                    }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).background(Color.blue)
                }.frame(maxWidth: .infinity,
                        minHeight: 200,
                        maxHeight: .infinity).border(Color.backgroundColorEventsHeader, width: 2)

                BottomDetailView(model: TestModels.model1) // TODO: Add proper model
            }
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top)
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView()
    }
}
