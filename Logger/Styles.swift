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

public enum LogLevel: Int, CodingKey {
    case verbose
    case debug
    case info
    case warning
    case error

    public func toString() -> String {
        switch self {
        case .verbose:
            return "VERBOSE"
        case .debug:
            return "DEBUG"
        case .info:
            return "INFO"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        }
    }

    public func toColor() -> Color {
        switch self {
        case .verbose:
            return Color(red: 252 / 255, green: 218 / 255, blue: 157 / 255)
        case .debug:
            return Color(red: 50 / 255, green: 172 / 255, blue: 65 / 255)
        case .info:
            return Color(red: 56 / 255, green: 128 / 255, blue: 248 / 255)
        case .warning:
            return Color(red: 232 / 255, green: 129 / 255, blue: 26 / 255)
        case .error:
            return Color(red: 228 / 255, green: 35 / 255, blue: 40 / 255)
        }
    }
}


extension Color {
    static var backgroundColor: Color {
        Color(red: 36 / 255, green: 32 / 255, blue: 37 / 255)
    }

    static var backgroundColorLeftBar: Color {
        Color(red: 45 / 255, green: 41 / 255, blue: 46 / 255)
    }
    
    static var backgroundColorEventsHeader: Color {
        Color(red: 48 / 255, green: 48 / 255, blue: 48 / 255)
    }

    static var backgroundColorTopBar: Color {
        Color(red: 61 / 255, green: 57 / 255, blue: 60 / 255)
    }

    static var backgroundColorSeparatorLine: Color {
        Color(red: 74 / 255, green: 70 / 255, blue: 73 / 255)
    }
    
    static var backgroundColorSeparatorLine2: Color {
        Color(red: 76 / 255, green: 76 / 255, blue: 76 / 255)
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
    
    static var rowBackgroundColor1: Color {
        Color(red: 48 / 255, green: 42 / 255, blue: 47 / 255)
    }

    static var rowBackgroundColor2: Color {
        Color(red: 38 / 255, green: 32 / 255, blue: 37 / 255)
    }
    
    static var bottomDetailViewColor: Color {
        Color(red: 38 / 255, green: 32 / 255, blue: 37 / 255)
    }
    
    static var bottomDetailViewDetailsColor: Color {
        Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255)
    }
    static var rowBacgroundColorSelected: Color {
        Color(red: 0 / 255, green: 89 / 255, blue: 211 / 255)
    }
}
