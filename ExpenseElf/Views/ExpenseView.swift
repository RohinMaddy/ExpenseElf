//
//  ExpenseView.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 25/05/2024.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    
    @State private var isShowingExpenseSheet = false
    @Query(sort: \Expense.date) var expenses: [Expense]
    @Environment(\.modelContext) private var context
    @State private var expneseToEdit: Expense?
    @State private var isExpenseUpdating: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expneseToEdit = expense
                            isExpenseUpdating = true
                        }
                }
                .onDelete{ indexSet in
                    for index in indexSet {
                        context.delete(expenses[index])
                    }
                }
            }
            .navigationTitle("Expense Elf")
            .sheet(isPresented: $isShowingExpenseSheet) {
                ExpenseSheet(expense: Expense(name: "", date: Date.now, value: 0), isUpdatingSheet: $isExpenseUpdating)
            }
            .sheet(item: $expneseToEdit) { expense in
                ExpenseSheet(expense: expense, isUpdatingSheet: $isExpenseUpdating)
            }
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add expense", systemImage: "plus") {
                        isShowingExpenseSheet = true
                        isExpenseUpdating = false
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding your expense here")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingExpenseSheet = true
                            isExpenseUpdating = false
                        }
                    })
                    .offset(y: -50)
                }
            }
        }
    }

}



#Preview {
    ExpenseView()
}
