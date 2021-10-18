//
//  TopButtonsBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopButtonsBar: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    @State var showFileChooser = false

    var body: some View {
        HStack {
            TopButton(imageName: "square.grid.3x1.folder.badge.plus", text: "Add existing Logs") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK {
                    if let url = panel.url {
                        loggerViewModel.loadExistedJSON(url: url)
                    }
                }
            }
            TopButton(imageName: "xmark.circle", text: "Clear", action: loggerViewModel.clearLoggerData)
            TopButton(imageName: "rectangle.and.pencil.and.ellipsis", text: "Copy IP address", action: loggerViewModel.copyIpAdress)
        }
    }
}

struct TopButtonsBar_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsBar(loggerViewModel: LoggerViewModel())
    }
}
