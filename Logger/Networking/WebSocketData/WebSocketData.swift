//
//  WebSocketData.swift
//  Logger
//
//  Created by Alex Zchut on 19/05/2022.
//

import Foundation

enum WSMessageType: String, Codable {
    // Client to server types
    case event
    // Server to client types
    case handshake
    // Command event to client
    case command
    // Storage event to client
    case storage
}

struct WSMessageTypeData: Codable {
    let type: WSMessageType
}

struct WSHandshake: Codable {
    var type: WSMessageType = .handshake
    let id: UUID
}

struct WSCommand: Codable {
    var type: WSMessageType = .command
    let command: String
}

struct WSMessageEvent: Codable {
    var type: WSMessageType = .event
    let id: UUID
    let event: String
}

struct WSStorage: Codable {
    let id: UUID
    var type: WSMessageType = .storage
    let data: [String: [String: [String: String]]]
}
