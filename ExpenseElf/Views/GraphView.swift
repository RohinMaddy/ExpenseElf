//
//  GraphView.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 27/05/2024.
//

import SwiftUI
import SwiftData
import Charts

struct GraphView: View {
    
    @Query(sort: \Expense.date) var expenses: [Expense]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            Chart(expenses) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.value)
                )
            }
            .padding(EdgeInsets(top: 50, leading: 20, bottom: 50, trailing: 20))
            .navigationTitle("Expense Graph")
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: { }, actions: { })
                }
            }
        }
    }
}

#Preview {
    GraphView()
}
