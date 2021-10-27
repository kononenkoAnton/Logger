//
//  NetworkLogTypeButton.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct NetworkLogTypeButton: View {
    @State private var isHover = false

    var text: String
    var action: (NetworkLogTypeButton) -> Void
    var isSelected: (NetworkLogTypeButton) -> Bool
    var buttonType: NetworkRequestStatusCode

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
                        Color(ColorKeys.FontColor) : Color(ColorKeys.FontColor2))
            }
            .background(selected ? buttonType.toColor() : isHover ? buttonType.toColor().opacity(0.3) : Color.clear).cornerRadius(5.0)
        }.onHover(perform: { hovering in
            isHover = hovering
        })
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.gray)
    }
}

struct NetworkLogTypeButton_Previews: PreviewProvider {
    static var previews: some View {
        NetworkLogTypeButton(text: "All keys", action: { _ in }, isSelected: { _ in true }, buttonType: .x500)
        NetworkLogTypeButton(text: "All keys", action: { _ in }, isSelected: { _ in false }, buttonType: .x200)
    }
}
