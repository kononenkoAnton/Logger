//
//  SideBarRow.swift
//  Logger
//
//  Created by Anton Kononenko on 10/25/21.
//

import SwiftUI

struct SideBarRow: View {
    let model:SideMenuDataModel.Data
    let isSelected: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6, style: .circular)
                .foregroundColor(isSelected ? Color.blue : Color.clear)

            HStack {
                Image(systemName: model.imageName).foregroundColor(isSelected ? Color.white : Color.blue)
                Text(model.text).foregroundColor(isSelected ? Color.white : Color.black)
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .leading)
                .padding(.horizontal, 10)
        }.frame(maxHeight: 30)
            .padding(.horizontal, 10)
    }
}

struct SideBarRow_Previews: PreviewProvider {
    static var previews: some View {
        SideBarRow(model: SideMenuDataModel.Data(screenType: SideMenuDataModel.ScreenTypes(rawValue: 0)!), isSelected: false)
    }
}
