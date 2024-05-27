//
//  MonthlyExpenseSheet.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 27/05/2024.
//

import SwiftUI
import SwiftData

struct MonthlyExpenseSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    var selectedDate: Date
    var expenses: [Expense]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                }
            }
            .navigationTitle(selectedDate.formatted(.dateTime.month()))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
