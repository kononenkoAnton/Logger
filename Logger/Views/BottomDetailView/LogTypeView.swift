//
//  LogTypeView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct LogTypeView: View {
    var logType:String
    var color:Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3).foregroundColor(color)
            Text(logType).padding(5)
        }.fixedSize()
    }
}

struct LogTypeView_Previews: PreviewProvider {
    static var previews: some View {
        LogTypeView(logType: "Debug", color: Color.blue)
    }
}
