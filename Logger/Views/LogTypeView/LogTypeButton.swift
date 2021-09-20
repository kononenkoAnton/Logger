//
//  LogTypeButton.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct LogTypeButton: View {
    @State private var isHover = false

    var text: String
    var action: (LogTypeButton) -> Void
    var isSelected: (LogTypeButton) -> Bool
    var buttonType: LogButtonTypes

    var body: some View {
        let selected = isSelected(self)
        Button(action: {
            action(self)
        }
        ) {
            VStack {
                Text(text)
                    .font(.subheadline)
                    .padding(5)
                    .foregroundColor(selected ?
                        Color.fontColor : Color.fontLightGrayColor)
            }
            .background(selected ? buttonType.toColor() : isHover ? buttonType.toColor().opacity(0.3) : Color.clear).cornerRadius(5.0)
        }.onHover(perform: { hovering in
            isHover = hovering
        })
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.gray)
    }
}

struct LogTypeButton_Previews: PreviewProvider {
    static var previews: some View {
        LogTypeButton(text: "All keys", action: {_ in }, isSelected: { _ in true}, buttonType: .allLogs)
        LogTypeButton(text: "All keys", action: {_ in }, isSelected: { _ in false}, buttonType: .allLogs)    }
}
