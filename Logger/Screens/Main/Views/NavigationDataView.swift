//
//  NavigationDataView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct NavigationDataView: View {
    let navigationViewModel: NavigationViewModel = NavigationViewModel()
    @State private var selection: UUID?

    init() {
        _selection = State(initialValue: navigationViewModel.getLoggerScreenNavigationModel().id)
    }

    var body: some View {
        NavigationSplitView {
            Text("Content")
                .font(.title2)
            List(navigationViewModel.models, id: \.id, selection: $selection) { navigationModel in
                let screen = navigationViewModel.getScreen(from: navigationModel)

                NavigationLink(destination: screen) {
                    Label(navigationModel.title, systemImage: navigationModel.iconImageName)
                }
            }
        } detail: { EmptyView() }
    }
}

// struct NavigationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationDataView(selection: "123")
//    }
// }
