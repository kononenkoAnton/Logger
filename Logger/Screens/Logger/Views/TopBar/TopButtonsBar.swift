//
//  TopButtonsBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct TopButtonsBar: View {
    @ObservedObject var loggerViewModel: LoggerViewModel

    @State var showFileChooser = false
    @State private var isExporting: Bool = false
    @State private var document: JSONFileDocument?
    @State private var documentName: String = "your_app_name"

    var body: some View {
        HStack {
            TopButton(imageName: TopViewIcons.addItem, text: "Add existing Logs") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                if panel.runModal() == .OK,
                   let url = panel.url {
                    loggerViewModel.loadExistedJSON(url: url)
                }
            }
            TopButton(imageName: TopViewIcons.exportItem, text: "ExportLogs") {
                isExporting.toggle()
                document = loggerViewModel.parseCurrentVisibleDataToJSONFileDocument()
                documentName = loggerViewModel.getExportDefaultName()
            }

            TopButton(imageName: TopViewIcons.clearItem, text: "Clear", action: loggerViewModel.clearLoggerData)
            TopButton(imageName: TopViewIcons.copyIpAdress, text: "Copy IP address", action: loggerViewModel.copyIpAdress)
        }
        .fileExporter(
            isPresented: $isExporting,
            document: document,
            contentType: UTType.json,
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

struct TopButtonsBar_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsBar(loggerViewModel: LoggerViewModel())
    }
}
