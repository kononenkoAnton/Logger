//
//  LocalSever.swift
//  Logger
//
//  Created by Anton Kononenko on 9/21/21.
//

import Foundation
import Swifter

class LocalSever {
    var server: HttpServer!

    func startLocalServer() {
        do {
            server = serverData(try String.File.currentWorkingDirectory())
            server["/testAfterBaseRoute"] = { request in
                print("Received request: \(request)")
                return .ok(.htmlBody("ok !"))
            }

            try server.start(9080,
                             forceIPv4: true)

            print("Server has started ( port = \(try server.port()) ). Try to connect now...")

//            RunLoop.main.run()

        } catch {
            print("Server start error: \(error)")
        }
    }

    func stopLocalServer() {
        server.stop()
        server = nil
    }
}
