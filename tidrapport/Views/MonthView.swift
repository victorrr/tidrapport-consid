//
//  MonthView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct MonthView: View {
    let month: Date
    let calendar = Calendar.current
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        VStack(alignment: .center) {
            Text(calendar.shortMonthSymbols[calendar.component(.month, from: month) - 1])
                .font(.title)
                .padding(.top, 8)
            HStack {
                CalendarCellView(text: "W",
                                 type: .week)
                ForEach(0..<7, id: \.self) { index in
                    CalendarCellView(text: daysOfWeek[index],
                                     type: .day)
                }
            }
            GridStack(rows: (range.count + startDayOfWeek + 6) / 7,
                      columns: 8) { row, col in
                if col > 0 {
                    if row * 7 + col >= startDayOfWeek {
                        let day = row * 7 + col - startDayOfWeek + 1
                        if day <= range.count {
                            let date = calendar.date(byAdding: .day, value: day - 1, to: startDate)!
                            CalendarCellView(text: "\(calendar.component(.day, from: date))",
                                             type: .date,
                                             selectable: true)
                        } else {
                            CalendarCellView(type: .date)
                        }
                    } else {
                        CalendarCellView(type: .date)
                    }
                } else {
                    CalendarCellView(text: weekNumber(for: row),
                                     type: .week)
                }
            }
        }
    }
}

// MARK: - Private

private extension MonthView {

    var range: Range<Int> { calendar.range(of: .day, in: .month, for: month)! }
    var startDate: Date { calendar.date(from: calendar.dateComponents([.year, .month], from: month))! }
    var startDayOfWeek: Int { calendar.component(.weekday, from: startDate) - 1 }

    func weekNumber(for row: Int) -> String {
        "\(calendar.component(.weekOfYear, from: calendar.date(byAdding: .day, value: row * 7, to: startDate)!))"
    }
}
