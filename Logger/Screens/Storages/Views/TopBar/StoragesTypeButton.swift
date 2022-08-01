//
//  StoragesTypeButton.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesTypeButton: View {
    @State private var isHover = false

    var text: String
    var action: (StoragesTypeButton) -> Void
    var isSelected: (StoragesTypeButton) -> Bool
    var buttonType: StoragesType

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

//struct StoragesTypeButton_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragesTypeButton()
//    }
//}
