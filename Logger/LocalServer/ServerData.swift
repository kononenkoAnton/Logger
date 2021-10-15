//
//  ServerData.swift
//  Logger
//
//  Created by Anton Kononenko on 9/21/21.
//

import Foundation
import Swifter

public func serverData(_ publicDir: String) -> HttpServer {
    print(publicDir)

    let server = HttpServer()

    server["/public/:path"] = shareFilesFromDirectory(publicDir)

    server["/files/:path"] = directoryBrowser("/")

    server.POST["/postBatchEvents"] = { request in
        let response = "OK"
        let body = request.body
        let stringJson = String(decoding: body, as: UTF8.self)
        let result = convertStringToArray(text: stringJson)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostEvent"), object: result)
        return HttpResponse.ok(.htmlBody(response))
    }
    server.POST["/postEvent"] = { request in
        let response = "OK"
        let body = request.body
        let stringJson = String(decoding: body, as: UTF8.self)
        let result = convertStringToDictionary(text: stringJson)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PostEvent"), object: result)
        return HttpResponse.ok(.htmlBody(response))
    }

    func convertStringToDictionary(text: String) -> [String: AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    func convertStringToArray(text: String) -> [[String: AnyObject]]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }

    return server
}
