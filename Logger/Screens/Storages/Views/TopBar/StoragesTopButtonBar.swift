//
//  StoragesTopButtonBar.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesTopButtonBar: View {
    @ObservedObject var storagesViewModel: StoragesViewModel
    
    @State var showFileChooser = false
    @State private var isExporting: Bool = false
    @State private var document: JSONFileDocument?
    @State private var documentName: String = "your_app_name"

    var body: some View {
        HStack {
            TopButton(imageName: TopViewIcons.reloadData, text: "Reload Storages") {
                storagesViewModel.reloadStorages()
            }
//            TopButton(imageName: TopViewIcons.addItem, text: "Add New Key") {
//
//             //TODO: Add new key for namespace
//            }
//            TopButton(imageName: TopViewIcons.exportItem, text: "Export All") {
//                isExporting.toggle()
//                //TODO: Add export all
////                document = storagesViewModel.parseCurrentVisibleDataToJSONFileDocument()
////                documentName = storagesViewModel.getExportDefaultName()
//            }
//
//            TopButton(imageName: TopViewIcons.clearItem, text: "Delete allData") {
////                storagesViewModel.deleteAllData
//                //TODO: Delete all data for storage type
//            }
        }
        .fileExporter(
            isPresented: $isExporting,
            document: document,
            contentType: .json,
            defaultFilename: documentName
        ) { result in
            
            if case let .success(url) = result {
                NSWorkspace.shared.activateFileViewerSelecting([url])
                Swift.print("Success!")
            } else {
                Swift.print("Something went wrong…")
            }
        }
    }
}

//struct StoragesTopButtonBar_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragesTopButtonBar()
//    }
//}
