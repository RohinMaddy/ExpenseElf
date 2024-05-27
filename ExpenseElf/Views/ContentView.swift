//
//  ContentView.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 23/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ExpenseView()
                .tabItem {
                    Label("Expense", systemImage: "sterlingsign.arrow.circlepath")
                }
            MonthView()
                .tabItem {
                    Label("Month", systemImage: "calendar")
                }
            GraphView()
                .tabItem {
                    Label("Graph", systemImage: "chart.xyaxis.line")
                }
        }
    }
}


#Preview {
    ContentView()
}
