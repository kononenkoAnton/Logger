//
//  StoragesTopView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesTopView: View {
    @ObservedObject var storagesViewModel: StoragesViewModel
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Storages").font(.headline).foregroundColor(Color(ColorKeys.TopTitleFontColor))
                    Spacer(minLength: 1)
                    Text("\(storagesViewModel.getEventsCount()) Namespaces")
                        .font(.subheadline).foregroundColor(Color(ColorKeys.FontColor2))

                }.padding(EdgeInsets(top: 10,
                                     leading: 10,
                                     bottom: 0,
                                     trailing: 0))
                Spacer()
                StoragesTopButtonBar(storagesViewModel: storagesViewModel).padding(EdgeInsets(top: 10,
                                                                                              leading: 0,
                                                                                              bottom: 0,
                                                                                              trailing: 10))
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
                StoragesTypeSelectorView(storagesViewModel: storagesViewModel)
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

// struct StoragesTopView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragesTopView()
//    }
// }
