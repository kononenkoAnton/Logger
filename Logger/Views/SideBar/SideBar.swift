//
//  SideBar.swift
//  Logger
//
//  Created by Anton Kononenko on 10/25/21.
//

import SwiftUI

struct SideBar: View {
    @ObservedObject private(set) var sideMenuViewModel: SideMenuViewModel
    @Binding var selectedData: SideMenuDataModel.Data

    var body: some View {
        Form {
            ForEach(sideMenuViewModel.data()) { model in
                SideBarRow(model: model,
                           isSelected: selectedData.index == model.index).onTapGesture {
                    withAnimation {
                        print("Seleted Index: \(model.index)")
                        selectedData = model
                        
                    }
                }.id(model.id)
            }
        }
    }
}

struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar(sideMenuViewModel: SideMenuViewModel(), selectedData: .constant(.init(screenType: .logger)))
    }
}

// List {
//    HStack {
//        Text("Logs").frame(width: 200, height: 100, alignment: .leading)
//    }.frame(maxWidth: .infinity, maxHeight: 100).background(Color.red)
// }
