//
//  SearchBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    // the inputted search text
    @State private var isEditing = false

    var body: some View {
        ZStack {
            TextField("Search", text: $text) { isEditing in
                print("On tap 2")

                self.isEditing = isEditing
            }
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 20))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay(
                HStack { // Add the search icon to the left
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .leading)
                        .padding(.leading, 8)

                    // If the search field is focused, add the clear (X) button
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                        }.buttonStyle(PlainButtonStyle())

                    }
                }
            ).padding(.horizontal, 10)

         

        }.frame(maxWidth: 500,
                maxHeight: 40, alignment: .top)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
