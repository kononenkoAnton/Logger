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
        VStack {
            TopView(clearAction: loggerViewModel.clearLoggerData,
                    copyIpAdressAction: loggerViewModel.copyIpAdress)

            LogsView().frame(maxWidth: .infinity,
                             maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel())
    }
}
