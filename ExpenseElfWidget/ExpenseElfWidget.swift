//
//  ExpenseElfWidget.swift
//  ExpenseElfWidget
//
//  Created by Rohin Madhavan on 03/10/2024.
//

import WidgetKit
import SwiftUI
import SwiftData
import Charts

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ExpenseEntry {
        ExpenseEntry(date: Date(), monthlyExpense: 2000.00)
    }

    func getSnapshot(in context: Context, completion: @escaping (ExpenseEntry) -> ()) {
        let entry = ExpenseEntry(date: Date(), monthlyExpense: 2000.00)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [ExpenseEntry] = []
        let currentDate = Date()

        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let entry = ExpenseEntry(date: entryDate, monthlyExpense: 0)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct ExpenseEntry: TimelineEntry {
    let date: Date
    let monthlyExpense: Double
}

func getMonthlyExpense(for date: Date) -> Double {

    
    return 0
}

struct ExpenseElfWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.modelContext) private var context
    @Query(sort: \Expense.date) var expenses: [Expense]

    var body: some View {
        let expenseData = ExpenseData(expenses: expenses)
        let currentDate = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: currentDate)
        let monthExpense = expenseData.monthExpenses.filter {calendar.component(.month, from: $0.month) == month}
        
        ZStack {
            if !expenses.isEmpty {
                VStack {
                    HStack {
                        Text(entry.date, format: .dateTime.month(.wide))
                            .fontWeight(.semibold)
                            .opacity(0.7)
                            .font(.title)
                        Spacer()
                        Text(monthExpense.first?.totalExpense ?? 0, format: .currency(code: "GBP"))
                            .fontWeight(.semibold)
                            .opacity(0.7)
                            .font(.title)
                    }
                    Chart(expenseData.monthExpenses.sorted(by: { $0.month < $1.month
                    })) {
                        BarMark(
                            x: .value("Month", $0.month.formatted(.dateTime.month())),
                            y: .value("expnenses", $0.totalExpense)
                        )
                    }
                }
            }
        }
        .overlay {
            if expenses.isEmpty {
                ContentUnavailableView(label: {
                    Label("", systemImage: "list.bullet.rectangle.portrait")
                }, description: { }, actions: { })
            }
        }
    }
}

struct ExpenseElfWidget: Widget {
    let kind: String = "ExpenseElfWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ExpenseElfWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    .modelContainer(for: [Expense.self])
            } else {
                ExpenseElfWidgetEntryView(entry: entry)
                    .padding()
                    .background()
                    .modelContainer(for: [Expense.self])
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    ExpenseElfWidget()
} timeline: {
    ExpenseEntry(date: .now, monthlyExpense: 2000.00)
    ExpenseEntry(date: .now, monthlyExpense: 2000.00)
}
