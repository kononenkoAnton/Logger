//
//  LoggerAppManager.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

protocol LoggerAppManagerDelegate {
    func sendConsoleCommand(_ command: String)
    func sendConsoleCommandShareCommandsList()
}

class LoggerAppManager: LocalWebSocketDelegate, LoggerAppManagerDelegate {
    
    func socketStatusDidUpdate(status: LocalWebSocket.Status) {
        
    }
    
    private var localServer = LocalSever()
    
    init() {
        localServer.startLocalServer()
    }
    
    func stopLocalServer() {
        localServer.stopLocalServer()
    }
    
    func sendConsoleCommand(_ command: String) {
        try? localServer.sendCommandToClient(command: command)
    }

    func sendConsoleCommandShareCommandsList() {
        try? localServer.sendCommandToClient(command: "cmdlist")
    }

}
