//
//  LogsView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import SwiftUI

struct NetworkLogsView: View {
    @ObservedObject var networkViewModel: NetworkViewModel
    @State var selectedModel: EventModel?

    var body: some View {
        GeometryReader { geometryReader in
            VStack {
                VSplitView {
                    List {
                        Section(header: NetworkEventsHeader()) {
                            let eventModels = networkViewModel.events()
                            ForEach(eventModels.indices, id: \.self) { index in
                                VStack {
                                    let currentModel = eventModels[index]
                                    NetworkEventRow(isSelected: currentModel.id == selectedModel?.id,
                                                model: currentModel,
                                                backgroundColor: index % 2 == 0 ? Color(ColorKeys.RowBackgroundColor1) : Color(ColorKeys.RowBackgroundColor2)).onTapGesture {
                                        networkViewModel.setModelSelected(model: eventModels[index])
                                        selectedModel = eventModels[index]
                                    }
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }.frame(maxWidth: .infinity,
                            minHeight: 200,
                            maxHeight: .infinity).border(Color(ColorKeys.BackgroundColorEventsHeader), width: 2)

                    NetworkBottomDetailView(networkViewModel: networkViewModel)
                }
            }.frame(minWidth: geometryReader.size.width,
                    maxHeight: .infinity,
                    alignment: .top)
        }
    }
}

struct NetworkLogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(loggerViewModel: LoggerViewModel())
    }
}
