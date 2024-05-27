//
//  MonthlyExpense.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 27/05/2024.
//

import Foundation

struct MonthlyExpense: Identifiable {
    var id = UUID()
    var month: Date
    var totalExpense: Double
}

