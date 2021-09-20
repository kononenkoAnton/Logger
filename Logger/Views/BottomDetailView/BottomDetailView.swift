//
//  BottomDetailView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct BottomDetailView: View {
    var model:EventModel
    var body: some View {
        VStack {
            InfoView(model: model).frame(maxWidth: .infinity)
            Divider().padding(.horizontal, 20)
            DetailsList(items: [])
        }.frame(maxWidth: .infinity,
                minHeight: 100,
                maxHeight: .infinity)
            .background(Color.bottomDetailViewColor)
    }
}

struct BottomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])

        BottomDetailView(model: model)
    }
}
