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
                CalendarCellView(viewModel: CalendarCellViewModel(text: "V", type: .week))
                ForEach(0..<7, id: \.self) { index in
                    CalendarCellView(viewModel: CalendarCellViewModel(text: viewModel.daysOfWeek[index], type: .day))
                }
            }
            GridStack(rows: viewModel.rows, columns: 8) { row, col in
                createCalendarCell(row: row, col: col)
            }
        }
    }
}

// MARK: - Private

private extension MonthView {

    func createCalendarCell(row: Int, col: Int) -> some View {
        let isWeekColumn = (col == 0)
        guard !isWeekColumn else {
            return AnyView(CalendarCellView(viewModel: CalendarCellViewModel(text: "\(viewModel.weekNumber(for: row))", type: .week)))
        }
        guard
            row * 7 + col >= viewModel.startDayOfWeek else {
            return AnyView(CalendarCellView(viewModel: CalendarCellViewModel(type: .emptyDate)))
        }
        let day = viewModel.day(for: row, col: col)
        guard day <= viewModel.range.count else {
            return AnyView(CalendarCellView(viewModel: CalendarCellViewModel(type: .emptyDate)))
        }
        return AnyView(CalendarCellView(viewModel: CalendarCellViewModel(text: viewModel.dateString(for: day), type: .date))
            .onTapGesture {
                let selectedDate = viewModel.date(for: day)
                if let index = viewModel.selectedDates.firstIndex(of: selectedDate) {
                    // Datumet är redan valt, så ta bort det från arrayen
                    viewModel.selectedDates.remove(at: index)
                } else {
                    // Datumet är inte valt, så lägg till det i arrayen
                    viewModel.selectedDates.append(selectedDate)
                }
            }
        )
    }
}

// MARK: - Preview

#Preview {
    let currentMonth = Calendar.current.date(from: DateComponents(year: 2024, month: 4))!
    let viewModel = MonthViewModel(month: currentMonth)
    return MonthView(viewModel: viewModel)
}
