//
//  ConnectionIndicator.swift
//  Logger
//
//  Created by Anton Kononenko on 6/17/22.
//

import SwiftUI

extension LocalWebSocket.Status {
    func toColor() -> Color {
        switch self {
        case .notConnected:
            return Color.yellow
        case .connected:
            return Color.green
        case .error:
            return Color.red
        }
    }
}

struct ConnectionIndicator: View {
    let connectionStatus: LocalWebSocket.Status

    var body: some View {
        Image(systemName: "circle.circle.fill").foregroundColor(connectionStatus.toColor()).font(.system(size: 10)).padding(3)
    }
}

struct ConnectionIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionIndicator(connectionStatus: .connected)
    }
}
