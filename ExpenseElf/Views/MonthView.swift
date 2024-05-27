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
    
    var body: some View {
        let expenseData = ExpenseData(expenses: expenses)
        NavigationStack {
            List {
                ForEach(expenseData.monthExpenses) { monthExpense in
                    MonthExpenseCell(date: monthExpense.month, totalExpense: monthExpense.totalExpense)
                        .onTapGesture {
                            date = monthExpense.month
                        }
                }
            }
            .navigationTitle("Monthy Expenses")
        }
        .sheet(item: $date) {  date in
            MonthlyExpenseSheet(selectedDate: date, expenses: expenseData.monthlyExpenseDict[date]!)
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

#Preview {
    MonthView()
}
