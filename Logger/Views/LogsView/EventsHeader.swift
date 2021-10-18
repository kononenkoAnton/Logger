//
//  EventsHeader.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import SwiftUI

struct EventsHeader: View {
    struct ColumnNames {
        static let Level = "Level"
        static let Time = "Time"
        static let Category = "Category"
        static let Subsystem = "Subsystem"
        static let Message = "Message"
    }

    var test = {
    }

    var body: some View {
        let devider = Divider().frame(width: 1, height: 20).foregroundColor(Color.backgroundColorSeparatorLine2)

        HStack {
            Text(ColumnNames.Level).frame(width: 50, alignment: .leading).padding(.horizontal, 10)
            devider
            Text(ColumnNames.Message).frame(alignment: .leading).padding(.horizontal, 10)
            Spacer()
            devider
            Text(ColumnNames.Subsystem).frame(width: 550, alignment: .leading).padding(.horizontal, 10)
            devider
            Text(ColumnNames.Category).frame(width: 200, alignment: .leading).padding(.horizontal, 10)
            devider
            Text(ColumnNames.Time).frame(width: 200, alignment: .leading).padding(.horizontal, 10)

        }.frame(maxWidth: .infinity, minHeight: 35, alignment: .leading).font(.headline).foregroundColor(.white).background(Color.backgroundColorEventsHeader)
    }
}

struct EventsHeader_Previews: PreviewProvider {
    static var previews: some View {
        EventsHeader()
    }
}
