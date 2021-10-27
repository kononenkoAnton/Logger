//
//  BottomDetailView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct NetworkBottomDetailView: View {
    @ObservedObject var networkViewModel: NetworkViewModel
    var body: some View {
        VStack {
            if let model = networkViewModel.getModelSelected() {
                InfoView(model: model).frame(maxWidth: .infinity)
                Divider().padding(.horizontal, 20)
                DetailsList(items: networkViewModel.dataModels(from: model))
            }
        }.frame(maxWidth: .infinity,
                minHeight: 100,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BottomDetailViewColor))
    }
}

struct NetworkBottomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkBottomDetailView(networkViewModel: NetworkViewModel())
    }
}
