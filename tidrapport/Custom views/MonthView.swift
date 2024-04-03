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
                CalendarCellView(text: "V", type: .week)
                ForEach(0..<7, id: \.self) { index in
                    CalendarCellView(text: viewModel.daysOfWeek[index], type: .day)
                }
            }
            GridStack(rows: viewModel.rows, columns: 8) { row, col in
                let isWeekColumn = (col == 0)
                if isWeekColumn {
                    CalendarCellView(text: "\(viewModel.weekNumber(for: row))", type: .week)
                } else {
                    if row * 7 + col >= viewModel.startDayOfWeek {
                        let day = viewModel.day(for: row, col: col)
                        if day <= viewModel.range.count {
                            CalendarCellView(text: viewModel.date(for: day), type: .date)
                        } else {
                            CalendarCellView(type: .emptyDate)
                        }
                    } else {
                        CalendarCellView(type: .emptyDate)
                    }
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
