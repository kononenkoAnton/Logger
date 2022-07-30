//
//  StoragestTableView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragestTableView: View {
    @ObservedObject var storagesViewModel: StoragesViewModel
    @State private var selection: StoragesRecordModel.ID?

    var body: some View {
        let eventModels = storagesViewModel.storageData()

        Table(eventModels, selection: $selection) {
            TableColumn("Key", value: \.key).width(min: 300, ideal: 300, max: 300)
            TableColumn("Value", value: \.value)
        }
//        .onChange(of: selection) { id in
//            loggerViewModel.selectModelById(id: id)
//        }
    }
}

//struct StoragestTableView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragestTableView()
//    }
//}
