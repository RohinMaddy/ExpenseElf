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
        let expenseData = ExpenseData(expenses: expenses)
        NavigationStack {
            Chart(expenseData.monthExpenses.sorted(by: { $0.month < $1.month
            })) {
                BarMark(
                    x: .value("Month", $0.month.formatted(.dateTime.month())),
                    y: .value("expnenses", $0.totalExpense)
                )
            }
            .padding(EdgeInsets(top: 50, leading: 25, bottom: 50, trailing: 25))
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
