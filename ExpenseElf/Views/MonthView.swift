//
//  MonthView.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 25/05/2024.
//

import SwiftUI
import SwiftData

struct MonthView: View {
    
    @Query(sort: \Expense.date) var expenses: [Expense]
    @Environment(\.modelContext) private var context
    private var groupedExpenses: [Date: [Expense]] {
        groupExpensesByMonth(expenses: expenses)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(groupedExpenses.keys.sorted(by: >)), id: \.self) { month in
                    HStack {
                        Text(month, format: .dateTime.month(.abbreviated).year())
                            .frame(width: 120, alignment: .leading)
                        Spacer()
                        Text(computeTotal(expenses: groupedExpenses[month]!), format: .currency(code: "GBP"))
                    }
                }
            }
            .navigationTitle("Monthy Expenses")
        }
        .overlay {
            if expenses.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                }, description: { }, actions: { })
            }
        }
    }
    
    func groupExpensesByMonth(expenses: [Expense]) -> [Date: [Expense]] {
        let grouped = Dictionary(grouping: expenses) { (expense) -> Date in
            return expense.date.startOfMonth()
        }
        return grouped
    }
    
    func computeTotal(expenses: [Expense]) -> Double {
        expenses.reduce(0) { partialResult, expense in
           partialResult + expense.value
        }
    }
}

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
}


#Preview {
    MonthView()
}
