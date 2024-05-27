//
//  MonthExpenseCell.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 27/05/2024.
//

import SwiftUI

struct MonthExpenseCell: View {
    let date: Date
    let totalExpense: Double
    
    var body: some View {
        HStack {
            Text(date, format: .dateTime.month(.abbreviated).year())
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text(totalExpense, format: .currency(code: "GBP"))
        }
    }
}

#Preview {
    MonthExpenseCell(date: Date.now, totalExpense: 2000)
}
