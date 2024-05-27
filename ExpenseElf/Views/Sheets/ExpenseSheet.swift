//
//  ExpenseSheet.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 24/05/2024.
//

import SwiftUI
import SwiftData

struct ExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var expense: Expense
    @Binding var isUpdatingSheet: Bool

    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "GBP")).keyboardType(.numberPad)
            }
            .navigationTitle("Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !isUpdatingSheet {
                        Button("Cancel") { dismiss() }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if !isUpdatingSheet {
                        Button("Save") {
                            let expense = Expense(name: expense.name, date: expense.date, value: expense.value)
                            context.insert(expense)
                            // Auto save enabled in swift data but just in case
                            do {
                                try context.save()
                            } catch {
                                fatalError("Unable to save data")
                            }
                            dismiss()
                        }
                    } else {
                        Button("Done") { dismiss() }
                    }
                }
            }
        }
    }
}
