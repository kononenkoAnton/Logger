//
//  LoggerApp.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

@main
struct LoggerApp: App {
    var body: some Scene {
        WindowGroup {
            MainLoggerView(applicationViewModel: ApplicationViewModel())
        }
    }
}
