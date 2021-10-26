//
//  ContentView.swift
//  Logger
//
//  Created by Anton Kononenko on 9/18/21.
//

import SwiftUI

struct MainLoggerView: View {
    @ObservedObject var applicationViewModel: ApplicationViewModel
//    @ObservedObject var loggerViewModel: LoggerViewModel
//    @ObservedObject var sideMenuViewModel: SideMenuViewModel
//
    @State var selectedData: SideMenuDataModel.Data = .init(screenType: .logger)

    var body: some View {
        GeometryReader { _ in
            HSplitView {
                VStack {
                    SideBar(sideMenuViewModel: applicationViewModel.sideMenuViewModel,
                            selectedData: $selectedData)
                        .padding(.top, 10)
                    Spacer()
                }.frame(maxWidth: 200,
                        maxHeight: .infinity)
                    .border(Color(ColorKeys.BackgroundColorEventsHeader),
                            width: 2)
                menuScreensSelector
            }
        }
    }

    var menuScreensSelector: some View {
        Group {
            switch selectedData.screenType {
            case .logger:
                mainLogger
            case .crashLogger:
                crashLogger
            case .networkLogger:
                networkLogger
            case .applicationData:
                applicationData
            case .settings:
                settings
            }
        }
    }

    var settings: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel,
                    title: SideMenuDataModel.ScreenTypes.settings.toString)

            LogsView(loggerViewModel: applicationViewModel.loggerViewModel,
                     selectedModel: applicationViewModel.loggerViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var applicationData: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel,
                    title: SideMenuDataModel.ScreenTypes.applicationData.toString)

            LogsView(loggerViewModel: applicationViewModel.loggerViewModel,
                     selectedModel: applicationViewModel.loggerViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var networkLogger: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.networkViewModel,
                    title: SideMenuDataModel.ScreenTypes.networkLogger.toString)

            LogsView(loggerViewModel: applicationViewModel.networkViewModel,
                     selectedModel: applicationViewModel.networkViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var crashLogger: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel,
                    title: SideMenuDataModel.ScreenTypes.crashLogger.toString)

            LogsView(loggerViewModel: applicationViewModel.loggerViewModel,
                     selectedModel: applicationViewModel.loggerViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }

    var mainLogger: some View {
        VStack {
            TopView(loggerViewModel: applicationViewModel.loggerViewModel,
                    title: SideMenuDataModel.ScreenTypes.logger.toString)

            LogsView(loggerViewModel: applicationViewModel.loggerViewModel,
                     selectedModel: applicationViewModel.loggerViewModel.getModelSelected())
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
        }.frame(idealWidth: 100,
                maxWidth: .infinity,
                maxHeight: .infinity)
            .background(Color(ColorKeys.BackgroundColor))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainLoggerView(loggerViewModel: LoggerViewModel(),
//                       sideMenuViewModel: SideMenuViewModel(),
//                       selectedData: .init(screenType: .logger))
//    }
//}
