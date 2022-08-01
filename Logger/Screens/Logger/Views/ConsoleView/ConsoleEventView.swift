//
//  ConsoleEventView.swift
//  Logger
//
//  Created by Anton Kononenko on 6/22/22.
//

import SwiftUI

struct ConsoleEventView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    @State private var consoleCommand: String = ""
    
    var body: some View {
        HStack {
            TextEditor(
                text: $consoleCommand
            ).font(.headline).cornerRadius(5).padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0))
            SendEventButton(text: "Print CMD") { _ in
                loggerViewModel.sendConsoleCommandShareCommandsLikst()
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 5))
            SendEventButton(text: "Send Command") { _ in
                loggerViewModel.sendConsoleCommand(consoleCommand)
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
 
        }.frame(maxWidth: .infinity,
                maxHeight: 65)
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        ConsoleEventView(loggerViewModel: LoggerViewModel())
    }
}
