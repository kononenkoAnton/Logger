//
//  TopButtonsBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopButtonsBar: View {
    var body: some View {
        HStack {
            TopButton(imageName: "xmark.circle", text: "Clear", action: {})
            TopButton(imageName: "rectangle.and.pencil.and.ellipsis", text: "Copy IP address", action: {})
        }
    }
}

struct TopButtonsBar_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsBar()
    }
}
