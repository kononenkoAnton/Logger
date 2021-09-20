//
//  LoggerViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import AppKit
import Foundation

class LoggerViewModel: ObservableObject {
    @Published var loggerModel = LoggerModel()
    init() {
//        printAddresses()
        let strIPAddress: String = getIPAddress()
        print("IPAddress : \(strIPAddress)")
    }

    // MARK: - Intents(s)

    func clearLoggerData() {
        // TODO: Should clear model data
    }

    func copyIpAdress() {
        let result = "http://\(getIPAddress()):9080"
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(result, forType: NSPasteboard.PasteboardType.string)
    }

    func dataModels(from model: EventModel) -> [[DataModel]] {
        return DataModelHelper.prepareDataSource(from:model)
    }

    
}
