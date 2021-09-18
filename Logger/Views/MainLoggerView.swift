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
        HStack {
            VStack {
             
            }.frame(minWidth: 50,
                    maxHeight: .infinity)
            .background(Color.backgroundColorBar)
            Rectangle()
                .foregroundColor(.black)
                .frame(maxWidth: 1, maxHeight: .infinity)

            VStack {
                TopView(clearAction: loggerViewModel.clearLoggerData,
                        copyIpAdressAction: loggerViewModel.copyIpAdress)
                Spacer()
            }.frame(maxWidth: .infinity)
        }.frame(minWidth: 0,
                idealWidth: 100,
                maxWidth: .infinity,
                minHeight: 0,
                idealHeight: 100,
                maxHeight: .infinity)
            .background(Color.backgroundColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel())
    }
}
