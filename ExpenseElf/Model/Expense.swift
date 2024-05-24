//
//  Expense.swift
//  ExpenseElf
//
//  Created by Rohin Madhavan on 23/05/2024.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
