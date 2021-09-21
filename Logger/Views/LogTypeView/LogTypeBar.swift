//
//  LogTypeBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct LogTypeBar: View {
    @ObservedObject var loggerViewModel: LoggerViewModel

    @State var selectedButton: Int
    
    init (loggerViewModel:LoggerViewModel) {
        self.loggerViewModel = loggerViewModel
        _selectedButton = State(initialValue: loggerViewModel.logLevel.rawValue)
    }
    
    var body: some View {
        HStack {
            LogTypeButton(text: "Error",
                          action: onSelect,
                          isSelected: isSelected,
                          buttonType: .error)
            LogTypeButton(text: "Warning",
                          action: onSelect,
                          isSelected: isSelected,
                          buttonType: .warning)
            LogTypeButton(text: "Debug",
                          action: onSelect,
                          isSelected: isSelected,
                          buttonType: .debug)
            LogTypeButton(text: "Info",
                          action: onSelect,
                          isSelected: isSelected,
                          buttonType: .info)
            LogTypeButton(text: "Verbose",
                          action: onSelect,
                          isSelected: isSelected,
                          buttonType: .verbose)
        }.padding(.horizontal, 10)
    }

    func onSelect(button: LogTypeButton) {
        selectedButton = button.buttonType.rawValue
        loggerViewModel.logLevel = button.buttonType
    }

    func isSelected(button: LogTypeButton) -> Bool {
        return button.buttonType.rawValue == selectedButton
    }
}

struct LogTypeBar_Previews: PreviewProvider {
    static var previews: some View {
        LogTypeBar(loggerViewModel: LoggerViewModel())
    }
}
