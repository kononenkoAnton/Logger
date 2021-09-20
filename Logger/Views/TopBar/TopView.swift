//
//  TopBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopView: View {
    var clearAction: () -> Void
    var copyIpAdressAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Logger").font(.headline).foregroundColor(Color.fontColor)
                    Spacer(minLength: 1)
                    Text("100 Messages").font(.subheadline).foregroundColor(Color.fontLightGrayColor)

                }.padding(EdgeInsets(top: 10,
                                     leading: 10,
                                     bottom: 0,
                                     trailing: 0))
                Spacer()
                TopButtonsBar(clearAction: clearAction,
                              copyIpAdressAction: copyIpAdressAction).padding(EdgeInsets(top: 10,
                                                                                         leading: 0,
                                                                                         bottom: 0,
                                                                                         trailing: 0))
                SearchBar()
                    .padding(EdgeInsets(top: 10,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: 0))
            }.frame(
                maxWidth: .infinity,
                minHeight: 45,
                maxHeight: 45)
                .background(Color.backgroundColorTopBar)
            Divider()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 1).foregroundColor(Color.backgroundColorSeparatorLine).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            HStack {
                LogTypeBar()
            }.frame(
                maxWidth: .infinity,
                minHeight: 20,
                maxHeight: 20,
                alignment: .leading)
                .background(Color.backgroundColorTopBar)
            Divider()
                .foregroundColor(.black)
                .frame(maxWidth: .infinity,
                       maxHeight: 1)

        }.frame(
            maxWidth: .infinity)
            .background(Color.backgroundColorTopBar)
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopView(clearAction: {}, copyIpAdressAction: {})
    }
}
