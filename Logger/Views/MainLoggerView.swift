//
//  ContentView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct MainLoggerView: View {
    @EnvironmentObject var applicationViewModel: ApplicationViewModel

    var body: some View {
        HSplitView {
            VStack {
                SideBar(sideMenuViewModel: applicationViewModel.sideMenuViewModel,
                        selectedData: $applicationViewModel.sideMenuViewModel.selectedData)
                    .padding(.top, 10)
                Spacer()
            }.frame(maxWidth: 200,
                    maxHeight: .infinity)
                .border(Color(ColorKeys.BackgroundColorEventsHeader),
                        width: 2)
            menuScreensSelector
        }
    }

    var menuScreensSelector: some View {
        Group {
            switch applicationViewModel.sideMenuViewModel.selectedData.screenType {
            case .logger:
                mainLogger
            case .networkLogger:
                networkLogger
            case .crashLogger:
                crashLogger
            case .applicationData:
                applicationData
            case .settings:
                settings
            }
        }
    }

    var networkLogger: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel, networkViewModel: applicationViewModel.networkViewModel, title: applicationViewModel.sideMenuViewModel.selectedData.screenType.toString) {
                NetworkLogTypeBar(networkViewModel: applicationViewModel.networkViewModel)
            }

            NetworkLogsView(networkViewModel: applicationViewModel.networkViewModel,
                            selectedModel: applicationViewModel.networkViewModel.getModelSelected())

                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var mainLogger: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel, networkViewModel: applicationViewModel.networkViewModel, title: applicationViewModel.sideMenuViewModel.selectedData.screenType.toString) {
                LogTypeBar(loggerViewModel: applicationViewModel.loggerViewModel)
            }

            LogsView(loggerViewModel: applicationViewModel.loggerViewModel,
                     selectedModel: applicationViewModel.loggerViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var settings: some View {
        EmptyView()
    }

    var applicationData: some View {
        EmptyView()
    }

    var crashLogger: some View {
        EmptyView()
    }
}

// struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainLoggerView(loggerViewModel: LoggerViewModel(),
//                       sideMenuViewModel: SideMenuViewModel(),
//                       selectedData: .init(screenType: .logger))
//    }
// }
