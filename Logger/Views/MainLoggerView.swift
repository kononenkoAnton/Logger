//
//  ContentView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct MainLoggerView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    @ObservedObject var sideMenuViewModel: SideMenuViewModel

    var body: some View {
        GeometryReader { _ in
            HSplitView {
                VStack {
                    SideBar(sideMenuViewModel: sideMenuViewModel)
                        .padding(.top, 10)
                    Spacer()
                }.frame(maxWidth: 200,
                        maxHeight: .infinity)
                    .border(Color(ColorKeys.BackgroundColorEventsHeader), width: 2)
                VStack {
                    TopView(loggerViewModel: loggerViewModel)

                    LogsView(loggerViewModel: loggerViewModel,
                             selectedModel: loggerViewModel.getModelSelected())
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                }.frame(idealWidth: 100,
                        maxWidth: .infinity,
                        maxHeight: .infinity)
                    .background(Color(ColorKeys.BackgroundColor))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel(),
                       sideMenuViewModel: SideMenuViewModel())
    }
}
