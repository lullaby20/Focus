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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    let quoteService = QuoteService()

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: MainViewModel(quoteService: quoteService))
        }
//        .modelContainer(sharedModelContainer)
    }
}

