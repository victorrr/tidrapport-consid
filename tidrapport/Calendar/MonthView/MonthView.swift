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
                CalendarCellView(viewModel: viewModel.weekViewModel)
                ForEach(viewModel.daysOfWeekViewModel, id: \.self) { day in
                    CalendarCellView(viewModel: day)
                }
            }
            GridStack(rows: viewModel.rows, columns: 8) { row, col in
                calendarCell(row: row, col: col)
            }
        }
    }
}

// MARK: - Private

private extension MonthView {

    func calendarCell(row: Int, col: Int) -> some View {
        guard let cellViewModel = viewModel.cellViewModels[GridKey(row: row, col: col)] else {
            return AnyView(EmptyView())
        }
        guard case .day = cellViewModel.type else {
            return AnyView(CalendarCellView(viewModel: cellViewModel))
        }
        return AnyView(CalendarCellView(viewModel: cellViewModel).onTapGesture {
            guard let selectedDate = cellViewModel.date else { return }
            if let index = viewModel.selectedDates.firstIndex(of: selectedDate) {
                // Datumet är redan valt, så ta bort det från arrayen
                viewModel.selectedDates.remove(at: index)
            } else {
                // Datumet är inte valt, så lägg till det i arrayen
                viewModel.selectedDates.append(selectedDate)
            }
        })
    }
}

// MARK: - Preview

#Preview {
    let currentMonth = Calendar.current.date(from: DateComponents(year: 2024, month: 4))!
    let viewModel = MonthViewModel(month: currentMonth)
    viewModel.addCellViewModels()
    return MonthView(viewModel: viewModel)
}
