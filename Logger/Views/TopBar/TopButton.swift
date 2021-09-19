//
//  TabButton.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopButton: View {
    @State private var isHover = false
    var imageName: String
    var text: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                VStack {
                    Image(systemName: imageName).padding(4)
                }.background(isHover ? Color.topButtonBackgroundHower : Color.clear).cornerRadius(5.0)
                Spacer(minLength: 0)
                Text(text).font(.subheadline)
            }

        }.buttonStyle(PlainButtonStyle())
            .foregroundColor(.gray)
            .onHover(perform: { hovering in
                isHover = hovering
            })
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TopButton(imageName: "xmark.circle", text: "Clear", action: {})
    }
}
