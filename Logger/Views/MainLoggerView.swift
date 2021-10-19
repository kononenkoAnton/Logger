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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel())
    }
}
