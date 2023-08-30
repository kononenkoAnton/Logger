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

    func applicationShouldTerminate() {
        LoggerAppManager.shared.stopLocalServer()
    }

    init() {
        appDelegate.delegate = self
        LoggerAppManager.shared.startLocalServer()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
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
