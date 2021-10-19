//
//  LogEventRow.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import SwiftUI

struct LogEventRow: View {
    var isSelected: Bool

    var model: EventModel

    var backgroundColor: Color
    var body: some View {
        HStack {
            Circle().frame(width: 10).padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 55)).foregroundColor(model.level.toColor())
            messageText
            Spacer()
            subsystemText
            categoryText
            dateText
        }
        .frame(maxWidth: .infinity, minHeight: 25, alignment: .leading)
        .background(isSelected ? Color(ColorKeys.RowBacgroundColorSelected) : backgroundColor)
    }

    @ViewBuilder private var messageText: some View {
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

    @ViewBuilder private var subsystemText: some View {
        let edgeInsets = EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let width: CGFloat = 450

        isSelected ?
            Text(model.subsystem)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .truncationMode(.head)
            .lineLimit(1)
            .frame(width: width, alignment: .leading)
            .padding(edgeInsets) :
            Text(model.subsystem)
            .truncationMode(.head)
            .lineLimit(1)
            .frame(width: width, alignment: .leading)
            .padding(edgeInsets)
    }

    @ViewBuilder private var categoryText: some View {
        let edgeInsets = EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 10)
        let width: CGFloat = 200
        isSelected ?
            Text(model.category)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .frame(width: width, alignment: .leading)
            .padding(edgeInsets) :
            Text(model.category)
            .frame(width: width, alignment: .leading)
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

struct LogEventRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = EventModel(id: "test", category: "Category", subsystem: "subsystem", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
        LogEventRow(isSelected: false, model: model, backgroundColor: Color.gray)
    }
}
