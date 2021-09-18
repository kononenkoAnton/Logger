//
//  TopBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Logger").font(.headline).foregroundColor(Color.fontColor())
                    Spacer(minLength: 1)
                    Text("100 Messages").font(.subheadline).foregroundColor(Color.fontLightGrayColor())

                }.padding(EdgeInsets(top: 0,
                                     leading: 10,
                                     bottom: 0,
                                     trailing: 0))
                Spacer()
            }.frame(
                maxWidth: .infinity,
                maxHeight: 55)
                .background(Color.backgroundColorBar())
            RoundedRectangle(cornerRadius: 25.0).frame(
                maxWidth: .infinity,
                maxHeight: 1).foregroundColor(Color.backgroundColorSeparatorLine()).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

            VStack {
                            }.frame(
                maxWidth: .infinity,
                maxHeight: 25)
                .background(Color.backgroundColorBar())
        }.frame(
            maxWidth: .infinity)
            .background(Color.backgroundColorBar())
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
