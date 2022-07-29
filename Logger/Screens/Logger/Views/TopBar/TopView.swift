//
//  TopBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Logger").font(.headline).foregroundColor(Color(ColorKeys.TopTitleFontColor))
                    Spacer(minLength: 1)
                    Text("\(loggerViewModel.events().count) Events")
                        .font(.subheadline).foregroundColor(Color(ColorKeys.FontColor2))

                }.padding(EdgeInsets(top: 10,
                                     leading: 10,
                                     bottom: 0,
                                     trailing: 0))
                Spacer()
                TopButtonsBar(loggerViewModel: loggerViewModel).padding(EdgeInsets(top: 10,
                                                                                   leading: 0,
                                                                                   bottom: 0,
                                                                                   trailing: 0))
                SearchBar(filteredData: loggerViewModel)
                    .padding(EdgeInsets(top: 10,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: 0))
            }.frame(
                maxWidth: .infinity,
                minHeight: 45,
                maxHeight: 45)
                .background(Color(ColorKeys.BackgroundColorTopBar))
            Divider()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 1).foregroundColor(Color(ColorKeys.BackgroundColorSeparatorLine)).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            HStack {
                LogTypeBar(loggerViewModel: loggerViewModel)
                ConnectionIndicator(connectionStatus: loggerViewModel.socketConnectionIndicator)
            }.frame(
                maxWidth: .infinity,
                minHeight: 20,
                maxHeight: 20,
                alignment: .leading)
                .background(Color(ColorKeys.BackgroundColorTopBar))
            Divider()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,
                       maxHeight: 1)

        }.frame(
            maxWidth: .infinity)
            .background(Color(ColorKeys.BackgroundColorTopBar))
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopView(loggerViewModel: LoggerViewModel())
        TopView(loggerViewModel: LoggerViewModel()).preferredColorScheme(.light)
    }
}
