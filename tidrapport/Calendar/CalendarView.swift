//
//  CalendarView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-25.
//

import SwiftUI

struct CalendarView: View {
    var viewModel = CalendarViewModel()

    var body: some View {
        List(1..<13, id: \.self) { month in
            MonthView(month: viewModel.dateForMonth(month))
        }
    }
}

// MARK: - Private

private extension CalendarView {

    var calendarDataList: [CalendarData] {
        viewModel.calendarDataForYear(year: 2024)
    }

}

// MARK: - Preview

#Preview {
    CalendarView()
}
