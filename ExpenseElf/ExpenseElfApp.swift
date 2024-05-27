//
//  ExpenseElfApp.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 23/05/2024.
//

import SwiftUI
import SwiftData

@main
struct ExpenseElfApp: App {
    
    var container: ModelContainer {
        let schema = Schema([Expense.self])
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [])
            return modelContainer
        } catch {
            fatalError("Unable to build container!")
        }
    }
        
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
//        .modelContainer(for: Expense.self)
    }
}
