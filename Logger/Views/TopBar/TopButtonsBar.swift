//
//  TopButtonsBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopButtonsBar: View {
    @EnvironmentObject var applicationViewModel: ApplicationViewModel
    @State var showFileChooser = false

    var body: some View {
        HStack {
            TopButton(imageName: "square.grid.3x1.folder.badge.plus", text: "Add existing Logs") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    if let url = panel.url {
                        applicationViewModel.loadExistedJSON(url: url)
                    }
                }
            }

            TopButton(imageName: "xmark.circle", text: "Clear", action: applicationViewModel.clearLoggerData)
            TopButton(imageName: "rectangle.and.pencil.and.ellipsis", text: "Copy IP address", action: applicationViewModel.copyIpAdress)
        }
    }
}

// struct TopButtonsBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TopButtonsBar(loggerViewModel: LoggerViewModel())
//    }
// }
