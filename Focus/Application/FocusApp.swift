//
//  FocusApp.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 12.05.2024.
//

import SwiftUI
import SwiftData

@main
struct FocusApp: App {
    @State private var showLaunchScreen: Bool = true
    
    let network = Network()
    let startDate = Date()

    var body: some Scene {
        WindowGroup {
            if showLaunchScreen {
                LaunchView(showLaunchScreen: $showLaunchScreen, startDate: startDate)
            } else {
                MainView(viewModel: MainViewModel(quoteRemoteDataSource: QuoteRemoteDataSource(network: network)),
                         startDate: startDate)
            }
        }
    }
}

