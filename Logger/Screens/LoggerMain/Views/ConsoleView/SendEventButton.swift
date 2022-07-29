//
//  SendEventButton.swift
//  Logger
//
//  Created by Anton Kononenko on 6/22/22.
//

import SwiftUI

struct SendEventButton: View {
    @State private var isHover = false

    var text: String
    var action: (SendEventButton) -> Void

    var body: some View {
        Button(action: {
            action(self)
        }
        ) {
            VStack {
                Text(text)
                    .font(.headline)
                    .padding(5)
                    .foregroundColor(Color(ColorKeys.FontColor2))
            }.frame(height: 45, alignment: .center)
                .background(isHover ? Color.red.opacity(0.3) : Color(ColorKeys.RowBackgroundColor1).opacity(1)).cornerRadius(5.0)
        }.keyboardShortcut(.return, modifiers: [.command]).onHover(perform: { hovering in
            isHover = hovering
        })
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.gray)
    }
}

struct SendEventButton_Previews: PreviewProvider {
    static var previews: some View {
        SendEventButton(text: "Send Event") { _ in }
    }
}
