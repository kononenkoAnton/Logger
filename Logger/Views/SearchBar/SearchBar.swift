//
//  SearchBar.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var loggerViewModel: LoggerViewModel
    @State var text: String = ""
    // the inputted search text
    @State private var isEditing = false
    
    init(loggerViewModel: LoggerViewModel) {
        self.loggerViewModel = loggerViewModel
        if let newFilterText = loggerViewModel.searchBarFilterData {
            _text = State(initialValue: newFilterText)
        }
    }
    var body: some View {
        ZStack {
            TextField("Search", text: $text, onEditingChanged: { isEditing in
                self.isEditing = isEditing

            }, onCommit: {
                loggerViewModel.searchBarFilterData = text
            })
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
                            loggerViewModel.searchBarFilterData = nil
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
        SearchBar(loggerViewModel: LoggerViewModel())
    }
}
