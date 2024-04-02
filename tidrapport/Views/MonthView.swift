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
                DateView(dateString: "W",
                         dateType: .week)
                ForEach(0..<7, id: \.self) { index in
                    DateView(dateString: daysOfWeek[index],
                             dateType: .day)
                }
            }

            let range = calendar.range(of: .day, in: .month, for: month)!
            let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: month))!
            let startDayOfWeek = calendar.component(.weekday, from: startDate) - 1

            GridStack(rows: (range.count + startDayOfWeek + 6) / 7,
                      columns: 8) { row, col in
                if col > 0 {
                    if row * 7 + col >= startDayOfWeek {
                        let day = row * 7 + col - startDayOfWeek + 1
                        if day <= range.count {
                            let date = calendar.date(byAdding: .day, value: day - 1, to: startDate)!
                            DateView(dateString: "\(calendar.component(.day, from: date))",
                                     dateType: .date,
                                     selectable: true)
                        } else {
                            DateView(dateType: .date)
                        }
                    } else {
                        DateView(dateType: .date)
                    }
                } else {
                    let weekNumber = calendar.component(.weekOfYear, from: calendar.date(byAdding: .day, value: row * 7, to: startDate)!)
                    DateView(dateString: "\(weekNumber)",
                             dateType: .week)

                }
            }
        }
    }
}
