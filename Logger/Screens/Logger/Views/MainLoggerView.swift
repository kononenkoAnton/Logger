//
//  ContentView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct MainLoggerView: View {
    @ObservedObject var loggerViewModel: LoggerViewModel = LoggerViewModel()
    @State private var isTargeted: Bool = false

    var body: some View {
        VStack {
            TopView(loggerViewModel: loggerViewModel)

            VSplitView {
                LogsTableView(loggerViewModel: loggerViewModel).frame(idealHeight: 500)
                BottomDetailView(loggerViewModel: loggerViewModel)
            }
            ConsoleEventView(loggerViewModel: loggerViewModel)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
            .onDrop(of: [.json], isTargeted: $isTargeted, perform: { providers in
                guard let provider = providers.first else { return false }
                _ = provider.loadDataRepresentation(for: .json) { data, error in
                                    if error == nil, let data {
                                        DispatchQueue.main.async {
                                            loggerViewModel.parseLoadedData(data)
                                        }
                                    }
                                }
                return true
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainLoggerView(loggerViewModel: LoggerViewModel())
    }
}
