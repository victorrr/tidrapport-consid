//
//  MonthViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-02.
//

import Foundation

final class MonthViewModel: ObservableObject {
    let daysOfWeek = ["M", "Ti", "O", "To", "F", "L", "S"]
    var cellViewModels: [GridKey: CalendarCellViewModel] = [:]
    private var month: Date
    private let calendar = Calendar.current
    @Published var allDatesSelected: Bool = false

    init(month: Date) {
        self.month = month
    }

    var selectedDates: [Date] {
        cellViewModels.values
            .filter { $0.isSelected }
            .compactMap { $0.date }
    }

    var monthName: String {
        calendar.standaloneMonthSymbols[calendar.component(.month, from: month) - 1]
    }

    var rows: Int {
        (range.count + startDayOfWeek + 6) / 7
    }

    var weekViewModel: CalendarCellViewModel {
        CalendarCellViewModel(text: "V", type: .week)
    }

    var daysOfWeekViewModel: [CalendarCellViewModel] {
        daysOfWeek.map { CalendarCellViewModel(text: $0, type: .weekDayName) }
    }

    func toggleAllValidDatesSelected() {
        allDatesSelected.toggle()
        cellViewModels.values
            .filter { $0.isSelectableDate }
            .forEach { $0.isSelected = allDatesSelected }
    }

    func addCellViewModels(isHoliday: (Date) -> Bool, isWeekend: (Date) -> Bool) {
        (0..<rows)
            .forEach { row in
                (0..<8).forEach { col in
                    let key = GridKey(row: row, col: col)
                    cellViewModels[key] = createCellViewModel(gridKey: key, isHoliday: isHoliday, isWeekend: isWeekend)
                }
            }
    }

    @MainActor func updateReportedTime(_ timeEntries: [TimeEntry]) {
        for (key, value) in cellViewModels {
            if let matchingTimeEntry = timeEntries.first(where: { $0.date == value.dateString }) {
                cellViewModels[key]?.timeEntry = matchingTimeEntry
            }
        }
    }
}

// MARK: - Private

private extension MonthViewModel {

    var range: Range<Int> {
        calendar.range(of: .day, in: .month, for: month)!
    }

    var startDate: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
    }

    var startDayOfWeek: Int {
        calendar.component(.weekday, from: startDate) - 1
    }

    func day(for row: Int, col: Int) -> Int {
        row * 7 + col - startDayOfWeek + 1
    }

    func date(for day: Int) -> Date {
        calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }

    func dateString(for day: Int) -> String {
        "\(calendar.component(.day, from: date(for: day)))"
    }

    func weekNumber(for row: Int) -> Int {
        calendar.component(.weekOfYear, from: calendar.date(byAdding: .day, value: row * 7, to: startDate)!)
    }

    func createCellViewModel(gridKey: GridKey, isHoliday: (Date) -> Bool, isWeekend: (Date) -> Bool) -> CalendarCellViewModel {
        let isWeekColumn = (gridKey.col == 0)
        guard !isWeekColumn else {
            return CalendarCellViewModel(text: "\(weekNumber(for: gridKey.row))",
                                         type: .week)
        }
        let isAfterMonthStartDay = gridKey.row * 7 + gridKey.col >= startDayOfWeek
        let day = day(for: gridKey.row, col: gridKey.col)
        let isBeforeMonthEndDay = day <= range.count
        guard isAfterMonthStartDay, isBeforeMonthEndDay else {
            return CalendarCellViewModel(type: .emptyDate)
        }
        let date = date(for: day)
        let isHoliday = isHoliday(date)
        let isWeekend = isWeekend(date)
        return CalendarCellViewModel(text: dateString(for: day),
                                     type: .date,
                                     date: date,
                                     isHoliday: isHoliday,
                                     isWeekend: isWeekend)
    }
}

// MARK: - GridKey

struct GridKey: Hashable {
    let row: Int
    let col: Int
}
