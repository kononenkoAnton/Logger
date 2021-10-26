//
//  ApplicationViewModel.swift
//  Logger
//
//  Created by Anton Kononenko on 10/26/21.
//

import Foundation

protocol LoggerViewModel2 {
}

class ApplicationViewModel: ObservableObject, LoggerViewModel2 {
    @Published var loggerViewModel = LoggerViewModel()
    @Published var networkViewModel = NetworkViewModel()

    @Published var sideMenuViewModel = SideMenuViewModel()

//    private(set) var selectedLoggerViewModel: LoggerViewModel2

    // MARK: - Intents(s)
}
