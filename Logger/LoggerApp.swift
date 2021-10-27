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
            let viewModel = ApplicationViewModel()
            MainLoggerView().environmentObject(viewModel)
        }
    }
}
