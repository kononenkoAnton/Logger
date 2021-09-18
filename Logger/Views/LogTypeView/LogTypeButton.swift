//
//  LogTypeButton.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct LogTypeButton: View {
    var text: String
    var action: () -> Void
    var isSelected: Bool

    var body: some View {
        Button(action: action) {
            VStack {
                Text(text).font(.subheadline).padding().foregroundColor(isSelected ? Color.fontColor : Color.fontLightGrayColor)
            }.background(isSelected ? Color.gray : Color.clear).cornerRadius(5.0)
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.gray)
    }
}

struct LogTypeButton_Previews: PreviewProvider {
    static var previews: some View {
        LogTypeButton(text: "All keys", action: {}, isSelected: true)
        LogTypeButton(text: "All keys", action: {}, isSelected: false)
    }
}
