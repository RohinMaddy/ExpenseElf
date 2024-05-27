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
    @State private var date: Date?
    private var groupedExpenses: [Date: [Expense]] {
        groupExpensesByMonth(expenses: expenses)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(groupedExpenses.keys.sorted(by: >)), id: \.self) { month in
                    MonthExpenseCell(date: month, totalExpense: computeTotal(expenses: groupedExpenses[month]!))
                        .onTapGesture {
                            date = month
                        }
                }
            }
            .navigationTitle("Monthy Expenses")
        }
        .sheet(item: $date) {  date in
            MonthlyExpenseSheet(selectedDate: date, expenses: groupedExpenses[date]!)
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

extension Date: Identifiable {
    public var id: Date { return self }
}

#Preview {
    MonthView()
}
