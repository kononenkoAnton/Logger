//
//  SideMenuViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import Foundation

class SideMenuViewModel: ObservableObject {
    @Published var sideMenuModel: SideMenuDataModel = SideMenuDataModel()

    var selectedData: SideMenuDataModel.Data = .init(screenType: .logger)

    // MARK: - Intents(s)

    func sideMenuModel(_ index: Int) -> SideMenuDataModel.Data? {
        sideMenuModel.data.first(where: { $0.screenType.rawValue == index })
    }

    func data() -> [SideMenuDataModel.Data] {
        sideMenuModel.data
    }
}
