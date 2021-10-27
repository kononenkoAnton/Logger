//
//  NetworkLogTypeBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct NetworkLogTypeBar: View {
    @ObservedObject var networkViewModel: NetworkViewModel

    @State var selectedButton: Int

    init(networkViewModel: NetworkViewModel) {
        self.networkViewModel = networkViewModel
        _selectedButton = State(initialValue: networkViewModel.statusCode.rawValue)
    }

    var body: some View {
        HStack {
            NetworkLogTypeButton(text: NetworkRequestStatusCode.x500.toString(),
                                 action: onSelect,
                                 isSelected: isSelected,
                                 buttonType: .x500)
            NetworkLogTypeButton(text: NetworkRequestStatusCode.x400.toString(),
                                 action: onSelect,
                                 isSelected: isSelected,
                                 buttonType: .x400)
            NetworkLogTypeButton(text: NetworkRequestStatusCode.x300.toString(),
                                 action: onSelect,
                                 isSelected: isSelected,
                                 buttonType: .x300)
            NetworkLogTypeButton(text: NetworkRequestStatusCode.x200.toString(),
                                 action: onSelect,
                                 isSelected: isSelected,
                                 buttonType: .x200)
        }.padding(.horizontal, 10)
    }

    func onSelect(button: NetworkLogTypeButton) {
        selectedButton = button.buttonType.rawValue
        networkViewModel.statusCode = button.buttonType
    }

    func isSelected(button: NetworkLogTypeButton) -> Bool {
        return button.buttonType.rawValue == selectedButton
    }
}

struct NetworkLogTypeBar_Previews: PreviewProvider {
    static var previews: some View {
        NetworkLogTypeBar(networkViewModel: NetworkViewModel())
    }
}
