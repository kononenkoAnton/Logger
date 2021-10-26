//
//  Xray.swift
//  xray
//
//  Created by Anton Kononenko on 7/9/20.
//  Copyright © 2020 Applicaster. All rights reserved.
//

import SwiftUI

public enum NetworkRequestStatusCode: Int {
    case x000 = 0
    case x200 = 200
    case x300 = 300
    case x400 = 400
    case x500 = 500

    public init?(statusCode: String) {
        let stringValue = "\(statusCode.first ?? "1")00"
        guard let intValue = Int(stringValue),
              let value = NetworkRequestStatusCode(rawValue: intValue) else {
            return nil
        }
        self = value
    }

    public func toString() -> String {
        switch self {
        case .x200:
            return "2xx"
        case .x300:
            return "3xx"
        case .x400:
            return "4xx"
        case .x500:
            return "5xx"
        default:
            return "0"
        }
    }

    public func toColor() -> Color {
        switch self {
        case .x200:
            return Color(red: 50 / 255, green: 172 / 255, blue: 65 / 255)
        case .x300:
            return Color(red: 252 / 255, green: 218 / 255, blue: 157 / 255)
        case .x400:
            return Color(red: 232 / 255, green: 129 / 255, blue: 26 / 255)
        case .x500:
            return Color(red: 228 / 255, green: 35 / 255, blue: 40 / 255)
        default:
            return Color.white
        }
    }
}
