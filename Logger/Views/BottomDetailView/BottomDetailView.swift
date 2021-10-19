//
//  BottomDetailView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct BottomDetailView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    var body: some View {
        VStack {
            if let model = loggerViewModel.getModelSelected() {
                InfoView(model: model).frame(maxWidth: .infinity)
                Divider().padding(.horizontal, 20)
                DetailsList(items: loggerViewModel.dataModels(from: model))
            }
        }.frame(maxWidth: .infinity,
                minHeight: 100,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BottomDetailViewColor))
    }
}

struct BottomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDetailView(loggerViewModel: LoggerViewModel())
    }
}
