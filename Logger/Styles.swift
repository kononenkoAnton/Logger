//
//  Styles.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

enum LogButtonTypes: Int {
    case allLogs
    case error
    case warning
    case debug
    case info
    case verbose
}

extension Color {
    static var backgroundColor: Color {
        Color(red: 36 / 255, green: 32 / 255, blue: 37 / 255)
    }

    static var backgroundColorLeftBar: Color {
        Color(red: 45 / 255, green: 41 / 255, blue: 46 / 255)
    }

    static var backgroundColorTopBar: Color {
        Color(red: 61 / 255, green: 57 / 255, blue: 60 / 255)
    }

    static var backgroundColorSeparatorLine: Color {
        Color(red: 74 / 255, green: 70 / 255, blue: 73 / 255)
    }

    static var fontLightGrayColor: Color {
        Color(red: 182 / 255, green: 179 / 255, blue: 182 / 255)
    }

    static var fontColor: Color {
        Color(red: 235 / 255, green: 235 / 255, blue: 235 / 255)
    }

    static var searchBarBackground: Color {
        Color(red: 57 / 255, green: 54 / 255, blue: 57 / 255)
    }

    static var topButtonBackgroundHower: Color {
        Color(red: 71 / 255, green: 67 / 255, blue: 70 / 255)
    }
}
