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
            titleView
            weekDaysView
            datesGrid
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: - Private

private extension MonthView {

    var titleView: some View {
        Text(viewModel.monthName.capitalized)
            .font(.title)
            .padding(.top, 8)
    }

    var weekDaysView: some View {
        HStack {
            CalendarCellView(viewModel: viewModel.weekViewModel)
            ForEach(viewModel.daysOfWeekViewModel, id: \.self) { day in
                CalendarCellView(viewModel: day)
            }
        }
    }

    var datesGrid: some View {
        GridStack(rows: viewModel.rows, columns: 8) { row, col in
            calendarCell(row: row, col: col)
        }
    }

    func calendarCell(row: Int, col: Int) -> some View {
        let gridKey = GridKey(row: row, col: col)
        guard let cellViewModel = viewModel.cellViewModels[gridKey] else {
            return AnyView(EmptyView())
        }
        switch cellViewModel.type {
        case .date:
            return AnyView(dateCell(cellViewModel: cellViewModel))
        case .emptyDate, .week, .weekDayName:
            return AnyView(CalendarCellView(viewModel: cellViewModel))
        }
    }

    func dateCell(cellViewModel: CalendarCellViewModel) -> some View {
        CalendarCellView(viewModel: cellViewModel)
            .simultaneousGesture(TapGesture().onEnded { _ in
                cellViewModel.isSelected.toggle()
            })
    }
}

// MARK: - Preview

#Preview {
    let currentMonth = Calendar.current.date(from: DateComponents(year: 2024, month: 4))!
    let viewModel = MonthViewModel(month: currentMonth)
    viewModel.addCellViewModels(isHoliday: { _ in return false},
                                isWeekend: { _ in return false})
    return MonthView(viewModel: viewModel)
}
