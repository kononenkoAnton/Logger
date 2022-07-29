//
//  BottomDetailView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

var cachedDetailsList: DetailsList?
var cachedModel: EventModel?

struct BottomDetailView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    var body: some View {
        return VStack {
            getDetailListComponent()
        }.frame(maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BottomDetailViewColor))
    }

    
    /// It returns new or cached details list component. It needed to prevent collapsing in case rerender same event model
    func getDetailListComponent() -> DetailsList? {
        if let model = loggerViewModel.getModelSelected() {
            if let cachedModel = cachedModel,
               cachedModel == model {
            } else {
                cachedDetailsList = DetailsList(items: loggerViewModel.dataModels(from: model))
                cachedModel = model
            }
        } else {
            cachedModel = nil
            cachedDetailsList = nil
        }
        return cachedDetailsList
    }
}

struct BottomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottomDetailView(loggerViewModel: LoggerViewModel())
    }
}
