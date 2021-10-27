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

    var method: String {
        guard let request = model.data?["request"] as? [String: Any],
              let method = request["method"] as? String else {
            return ""
        }
        return method
    }

    var url: String {
        guard let request = model.data?["request"] as? [String: Any],
              let url = request["url"] as? String else {
            return "Can not find url, please check logs data"
        }
        return url
    }

    @ViewBuilder private var codeText: some View {
        let methodEdgeInsets = EdgeInsets(top: 5, leading: 12, bottom: 0, trailing: 10)
        let edgeInsets = EdgeInsets(top: 0, leading: 12, bottom: 5, trailing: 10)

        let codeDescription = model.httpStatusCodeDescription?.description ?? "no code"
        let color = model.networkStatusCode.toColor()
        let width: CGFloat = 150

        VStack {
            Text(method)
                .bold()
                .foregroundColor(Color(isSelected ? ColorKeys.RowFontColorSelectedMethod : ColorKeys.RowFontColorMethod))
                .padding(methodEdgeInsets)
            isSelected ?
                Text(codeDescription)
                .bold()
                .foregroundColor(color)
                .frame(alignment: .center)
                .padding(edgeInsets) :
                Text(codeDescription)
                .bold()
                .foregroundColor(color)
                .frame(alignment: .center)
                .padding(edgeInsets)
        }.frame(width: width,
                alignment: .center)
    }

    @ViewBuilder private var urlText: some View {
        let edgeInsets = EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 10)
        isSelected ?
            Text(url)
            .foregroundColor(Color(ColorKeys.RowFontColorSelected))
            .frame(alignment: .leading)
            .padding(edgeInsets) :
            Text(url)
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

// struct NetworkEventRow_Previews: PreviewProvider {
//    static var previews: some View {
//        let model = NetworkEventRow(id: "test", timeStamp: 211244, level: .debug, message: "My loogger message", data: [:], context: [:])
//        LogEventRow(isSelected: false, model: model, backgroundColor: Color.gray)
//    }
// }
