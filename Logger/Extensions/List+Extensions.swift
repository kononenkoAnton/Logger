//
//  List+Extensions.swift
//  Logger
//
//  Created by Anton Kononenko on 9/21/21.
//

import Introspect
import SwiftUI

extension List {
    /// List on macOS uses an opaque background with no option for
    /// removing/changing it. listRowBackground() doesn't work either.
    /// This workaround works because List is backed by NSTableView.
    func setBackgroundColor(color: NSColor) -> some View {
        return introspectTableView { tableView in
            tableView.backgroundColor = color
            tableView.enclosingScrollView!.drawsBackground = false
        }
    }
}
