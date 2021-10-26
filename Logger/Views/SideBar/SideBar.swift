//
//  SideBar.swift
//  Logger
//
//  Created by Anton Kononenko on 10/25/21.
//

import SwiftUI

struct SideBar: View {
    @ObservedObject private(set) var sideMenuViewModel: SideMenuViewModel
    @State var selectedIndex: Int = 0

    var body: some View {
        Form {
            ForEach(sideMenuViewModel.data()) { model in
                SideBarRow(model: model,
                           isSelected: selectedIndex == model.index).onTapGesture {
                    withAnimation {
                        selectedIndex = model.index
                    }
                }.id(model.id)
            }
        }
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar(sideMenuViewModel: SideMenuViewModel())
    }
}

// List {
//    HStack {
//        Text("Logs").frame(width: 200, height: 100, alignment: .leading)
//    }.frame(maxWidth: .infinity, maxHeight: 100).background(Color.red)
// }
