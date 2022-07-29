//
//  NavigationDataView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct NavigationDataView: View {
    let navigationViewModel = NavigationViewModel()
    @State private var selection: NavigationModel.ID?

    var body: some View {
        VStack {
            Text("Content")
                .font(.title2)
            List(navigationViewModel.models, id: \.self, selection: $selection) { navigationModel in
                let screen = navigationViewModel.getScreen(from: navigationModel)
                NavigationLink(destination: screen) {
                    Label(navigationModel.title, systemImage: navigationModel.iconImageName)
                }
            }
        }
    }
}

//struct NavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationDataView(selection: "123")
//    }
//}
