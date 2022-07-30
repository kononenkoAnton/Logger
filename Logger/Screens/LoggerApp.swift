//
//  LoggerApp.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

@main
struct LoggerApp: App, ApplicationDelegateProtocol {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let loggerViewModel: LoggerViewModel
    func applicationShouldTerminate() {
        loggerViewModel.stopLocalServer()
    }

    init() {
        loggerViewModel = LoggerViewModel()
        appDelegate.delegate = self
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                NavigationDataView()
            }
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var delegate: LoggerApp!

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        delegate.applicationShouldTerminate()
        return true
    }
}

protocol ApplicationDelegateProtocol {
    func applicationShouldTerminate()
}
