//
//  Styles.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

public enum LogLevel: Int, CodingKey {
    case undefined = 0
    case verbose
    case debug
    case info
    case warning
    case error

    public func toString() -> String {
        switch self {
        case .verbose:
            return "VERBOSE"
        case .info:
            return "INFO"
        case .debug:
            return "DEBUG"
        case .warning:
            return "WARNING"
        case .error:
            return "ERROR"
        case .undefined:
            return "Undefined"
        }
    }

    public func toColor() -> Color {
        switch self {
        case .verbose:
            return Color(red: 56 / 255, green: 128 / 255, blue: 248 / 255)
        case .debug:
            return Color(red: 50 / 255, green: 172 / 255, blue: 65 / 255)
        case .info:
            return Color(red: 255 / 255, green: 199 / 255, blue: 6 / 255)
        case .warning:
            return Color(red: 232 / 255, green: 129 / 255, blue: 26 / 255)
        case .error:
            return Color(red: 228 / 255, green: 35 / 255, blue: 40 / 255)
        case .undefined:
            return Color.black
        }
    }
}


let CatalogName = "Assets"
struct ColorKeys {
    static let BackgroundColor = "BackgroundColor"
    static let BackgroundColorTopBar = "BackgroundColorTopBar"
    static let BottomDetailViewColor = "BottomDetailViewColor"
    static let RowBacgroundColorSelected = "RowBacgroundColorSelected"
    static let RowBackgroundColor1 = "RowBackgroundColor1"
    static let RowBackgroundColor2 = "RowBackgroundColor2"
    static let TopButtonBackgroundHower = "TopButtonBackgroundHower"
    static let BackgroundColorEventsHeader = "BackgroundColorEventsHeader"
    static let BackgroundFontColorEventsHeader = "BackgroundFontColorEventsHeader"
    static let BackgroundColorSeparatorLine = "BackgroundColorSeparatorLine"
    static let BackgroundColorSeparatorLine2 = "BackgroundColorSeparatorLine2"
    static let FontColor = "FontColor"
    static let FontColor2 = "FontColor2"
    static let TopTitleFontColor = "TopTitleFontColor"
    static let BackgroundDetailListColor = "BackgroundDetailListColor"
    static let BottomDetailedViewFont = "BottomDetailedViewFont"
    static let RowFontColorSelected = "RowFontColorSelected"
}
