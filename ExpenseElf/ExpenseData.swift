//
//  ExpenseData.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 27/05/2024.
//

import Foundation

class ExpenseData: ObservableObject {

    var expenses: [Expense]
    init(expenses: [Expense]) {
        self.expenses = expenses
    }
    
    var monthlyExpenseDict: [Date: [Expense]] {
        groupExpensesByMonth(expenses: expenses)
    }
    
    var monthExpenses: [MonthlyExpense] {
        let groupedExpenses = groupExpensesByMonth(expenses: expenses)
        return groupedExpenses.map { (month, expenses) in
            MonthlyExpense(month: month, totalExpense: expenses.reduce(0) { $0 + $1.value })
        }.sorted { $0.month > $1.month }
    }
    
    func groupExpensesByMonth(expenses: [Expense]) -> [Date: [Expense]] {
        let grouped = Dictionary(grouping: expenses) { (expense) -> Date in
            return expense.date.startOfMonth()
        }
        return grouped
    }
    
}

extension Date: Identifiable {
    public var id: Date { return self }
}

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
}
