//
//  JSONFileDocument.swift
//  Logger
//
//  Created by Anton Kononenko on 6/20/22.
//

import Foundation
import UniformTypeIdentifiers
import SwiftUI

struct JSONFileDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }

    var jsonData: Data

    init(jsonData: Data) {
        self.jsonData = jsonData
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        jsonData = data
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: jsonData)
    }
}
