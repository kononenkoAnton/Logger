//
//  SideMenuData.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import Foundation

struct SideMenuDataModel {
    let data: [Data]
    struct Data: Identifiable, Hashable {
        var screenType: ScreenTypes

        var id: Int {
            screenType.index
        }

        var text: String {
            screenType.toString
        }

        var imageName: String {
            screenType.systemImageName
        }

        var index: Int {
            screenType.rawValue
        }
    }

    enum ScreenTypes: Int {
        case logger
        case crashLogger
        case networkLogger
        case applicationData
        case settings

        var index: Int {
            rawValue
        }

        var systemImageName: String {
            switch self {
            case .logger:
                return "note.text"
            case .crashLogger:
                return "exclamationmark.3"
            case .networkLogger:
                return "network"
            case .applicationData:
                return "info.circle"
            case .settings:
                return "gearshape"
            }
        }

        var toString: String {
            switch self {
            case .logger:
                return "Logger"
            case .crashLogger:
                return "Crash Logger"
            case .networkLogger:
                return "Network Logger"
            case .applicationData:
                return "Application Data"
            case .settings:
                return "Settings"
            }
        }
    }

    init() {
        let logger: ScreenTypes = .logger
        let errorlogger: ScreenTypes = .crashLogger
        let networkLogger: ScreenTypes = .networkLogger
        let applicationData: ScreenTypes = .applicationData
        let settings: ScreenTypes = .settings
        data = [
            Data(screenType: logger),
            Data(screenType: errorlogger),
            Data(screenType: networkLogger),
            Data(screenType: applicationData),
            Data(screenType: settings),
        ]
    }
}
