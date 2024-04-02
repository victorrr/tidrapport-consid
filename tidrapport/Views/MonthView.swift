//
//  MonthView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct MonthView: View {
    @ObservedObject var viewModel: MonthViewModel

    var body: some View {
        VStack(alignment: .center) {
            Text(viewModel.monthName.capitalized)
                .font(.title)
                .padding(.top, 8)
            HStack {
                CalendarCellView(text: "W", type: .week)
                ForEach(0..<7, id: \.self) { index in
                    CalendarCellView(text: viewModel.daysOfWeek[index], type: .day)
                }
            }
            GridStack(rows: viewModel.rows, columns: 8) { row, col in
                if col > 0 {
                    if row * 7 + col >= viewModel.startDayOfWeek {
                        let day = viewModel.day(for: row, col: col)
                        if day <= viewModel.range.count {
                            let date = viewModel.date(for: day)
                            CalendarCellView(text: "\(viewModel.calendar.component(.day, from: date))", type: .date)
                        } else {
                            CalendarCellView(type: .date)
                        }
                    } else {
                        CalendarCellView(type: .date)
                    }
                } else {
                    CalendarCellView(text: "\(viewModel.weekNumber(for: row))", type: .week)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    let currentMonth = Calendar.current.date(from: DateComponents(year: 2024, month: 4))!
    let viewModel = MonthViewModel(month: currentMonth)
    return MonthView(viewModel: viewModel)
}
