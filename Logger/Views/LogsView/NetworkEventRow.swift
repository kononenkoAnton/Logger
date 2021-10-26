//
//  LogEventRow.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct NetworkEventRow: View {
    var isSelected: Bool
    var model: EventModel
 
    var backgroundColor: Color
    var body: some View {
        HStack {
            codeText
            urlText
            Spacer()
            dateText
        }
        .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
        .background(isSelected ? Color(ColorKeys.RowBacgroundColorSelected) : backgroundColor)
    }

    @ViewBuilder private var codeText: some View {
        let edgeInsets = EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 10)
        isSelected ?
            Text(model.message)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .frame(alignment: .leading)
            .padding(edgeInsets) :
            Text(model.message)
            .frame(alignment: .leading)
            .padding(edgeInsets)
    }

    @ViewBuilder private var urlText: some View {
        let edgeInsets = EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 10)
        isSelected ?
            Text(model.message)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .frame(alignment: .leading)
            .padding(edgeInsets) :
            Text(model.message)
            .frame(alignment: .leading)
            .padding(edgeInsets)
    }

    @ViewBuilder private var dateText: some View {
        let width: CGFloat = 200
        let padding: CGFloat = 10
        isSelected ?
            Text(model.dateInString)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, 10) :
            Text(model.dateInString)
            .frame(width: width, alignment: .leading)
            .padding(.horizontal, padding)
    }
}

struct NetworkEventRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        LogEventRow(isSelected: false, model: model, backgroundColor: Color.gray)
    }
}
