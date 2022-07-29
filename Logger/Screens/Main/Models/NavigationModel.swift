//
//  NavigationModel.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

struct NavigationModel: Identifiable, Hashable {
    enum ScreenType: String {
        case Logger
        case Storages
    }

    let id = UUID()

    var title: String {
        screenType.rawValue
    }

    let iconImageName: String
    let screenType: ScreenType
    
    static func == (lhs: NavigationModel, rhs: NavigationModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
