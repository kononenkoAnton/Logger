//
//  NavigationViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation
import SwiftUI

class NavigationViewModel{
    let models: [NavigationModel]

    lazy var mainLoggerScreen = AnyView(MainLoggerView())
    lazy var storagesScreen = AnyView(StoragesView())
    
    init() {
        models = Self.prepareNavigationModels()
    }

    class func prepareNavigationModels() -> [NavigationModel] {
        let loggerScreen = NavigationModel(iconImageName: NavigationIcons.list, screenType: .Logger)
        let storagesScreen = NavigationModel(iconImageName: NavigationIcons.drive, screenType: .Storages)

        return [loggerScreen, storagesScreen]
    }

    func getScreen(from navigationModel: NavigationModel) -> AnyView {
        switch navigationModel.screenType {
        case .Logger:
            return mainLoggerScreen
        case .Storages:
            return storagesScreen
        }
    }
}
