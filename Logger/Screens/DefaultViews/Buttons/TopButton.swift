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
    @ScaledMetric(relativeTo:.body) var height = 14 // default height of body

    var body: some View {
        Button(action: action) {
            VStack {
                VStack {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height:height)

                    Text(text).font(.subheadline)
                }
                    .background(isHover ? Color(ColorKeys.TopButtonBackgroundHower) : Color.clear).cornerRadius(5.0)
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
