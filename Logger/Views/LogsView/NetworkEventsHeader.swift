//
//  EventsHeader.swift
//  Logger
//
//  Created by Anton Kononenko on 9/19/21.
//

import SwiftUI

struct NetworkEventsHeader: View {
    struct ColumnNames {
        static let Level = "Method/ Code"
        static let URL = "URL"
        static let Time = "Time"
    }

    var test = {
    }

    var body: some View {
        let devider = Divider().frame(width: 1, height: 20).foregroundColor(Color(ColorKeys.BackgroundColorSeparatorLine2))

        HStack {
            Text(ColumnNames.Level)
                .foregroundColor(Color(ColorKeys.BackgroundFontColorEventsHeader))
                .frame(width: 150, alignment: .leading)
                .padding(.horizontal, 10)
            devider
            Text(ColumnNames.URL)
                .foregroundColor(Color(ColorKeys.BackgroundFontColorEventsHeader))
                .frame(alignment: .leading)
                .padding(.horizontal, 10)
            Spacer()
            devider
            Text(ColumnNames.Time)
                .foregroundColor(Color(ColorKeys.BackgroundFontColorEventsHeader))
                .frame(width: 200, alignment: .leading)
                .padding(.horizontal, 10)

        }.frame(maxWidth: .infinity, minHeight: 35, alignment: .leading).font(.headline).foregroundColor(.white).background(Color(ColorKeys.BackgroundColorEventsHeader))
    }
}

struct NetworkEventsHeader_Previews: PreviewProvider {
    static var previews: some View {
        NetworkEventsHeader()
    }
}
