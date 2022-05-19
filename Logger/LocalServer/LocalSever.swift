//
//  LocalSever.swift
//  Logger
//
//  Created by Anton Kononenko on 9/21/21.
//

import Foundation
import Swifter
//Example iPV6 "http://[2600:1006:b00e:1966:45de:b8b5:5f57:94e3]:9080/postEvent"
class LocalSever {
    var server: LocalWebSocket!

    func startLocalServer() {
        let server = LocalWebSocket()
        server.start()
        // To check if the connection is established at port 8080, run
        // sudo lsof -i :8080 from command line to verify connection on given port
        server.completion = { value in
            DispatchQueue.main.async {
                print("Server output: \(value)")
            }
        }

        print("Server has started ( port = \(server.port ?? 0))")
    }

    func stopLocalServer() {
        server.stop()
        server = nil
    }
}
