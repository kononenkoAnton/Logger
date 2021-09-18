//
//  TopButtonsBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct TopButtonsBar: View {
    var clearAction: () -> Void
    var copyIpAdressAction: () -> Void
    var body: some View {
        HStack {
            TopButton(imageName: "xmark.circle", text: "Clear", action: clearAction)
            TopButton(imageName: "rectangle.and.pencil.and.ellipsis", text: "Copy IP address", action: copyIpAdressAction)
        }
    }
}

struct TopButtonsBar_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonsBar(clearAction: {}, copyIpAdressAction: {})
    }
}
