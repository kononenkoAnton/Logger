//
//  ContentView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct MainLoggerView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel

    var body: some View {
        GeometryReader { geometry in

            VStack {
                TopView(loggerViewModel: loggerViewModel)
                
                VSplitView {
                    LogsTableView(loggerViewModel: loggerViewModel).frame(idealHeight:500)
                    BottomDetailView(loggerViewModel: loggerViewModel)
                }
                ConsoleEventView(loggerViewModel: loggerViewModel)
            }.frame(idealWidth: 100,
                    maxWidth: .infinity,
                    maxHeight: .infinity)
                .background(Color(ColorKeys.BackgroundColor))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel())
    }
}
