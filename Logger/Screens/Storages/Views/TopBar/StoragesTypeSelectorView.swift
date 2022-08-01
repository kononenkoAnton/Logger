//
//  StoragesTypeSelectorView.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import SwiftUI

struct StoragesTypeSelectorView: View {
    @ObservedObject var storagesViewModel: StoragesViewModel

    @State var selectedButton: Int

    init(storagesViewModel: StoragesViewModel) {
        self.storagesViewModel = storagesViewModel
        _selectedButton = State(initialValue: storagesViewModel.storageType.rawValue)
    }

    var body: some View {
        HStack {
            StoragesTypeButton(text: "Local Storage",
                               action: onSelect,
                               isSelected: isSelected,
                               buttonType: .local)
            StoragesTypeButton(text: "Session Storage",
                               action: onSelect,
                               isSelected: isSelected,
                               buttonType: .session)
            StoragesTypeButton(text: "Keychain Storage",
                               action: onSelect,
                               isSelected: isSelected,
                               buttonType: .keychain)

        }.padding(.horizontal, 10)
    }

    func onSelect(button: StoragesTypeButton) {
        selectedButton = button.buttonType.rawValue
        storagesViewModel.storageType = button.buttonType
    }

    func isSelected(button: StoragesTypeButton) -> Bool {
        return button.buttonType.rawValue == selectedButton
    }
}

//
// struct StoragesTypeSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        StoragesTypeSelectorView()
//    }
// }
