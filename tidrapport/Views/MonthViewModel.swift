//
//  MonthViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-02.
//

import Foundation

class MonthViewModel: ObservableObject {
    @Published var month: Date
    let calendar = Calendar.current
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]

    init(month: Date) {
        self.month = month
    }

    var range: Range<Int> {
        calendar.range(of: .day, in: .month, for: month)!
    }

    var monthName: String {
        calendar.standaloneMonthSymbols[calendar.component(.month, from: month) - 1]
    }

    var startDate: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
    }

    var startDayOfWeek: Int {
        calendar.component(.weekday, from: startDate) - 1
    }

    var rows: Int {
        (range.count + startDayOfWeek + 6) / 7
    }

    func day(for row: Int, col: Int) -> Int {
        row * 7 + col - startDayOfWeek + 1
    }

    func date(for day: Int) -> Date {
        calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }

    func weekNumber(for row: Int) -> Int {
        calendar.component(.weekOfYear, from: calendar.date(byAdding: .day, value: row * 7, to: startDate)!)
    }
}
