//
//  CalendarView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-25.
//

import SwiftUI

struct CalendarView: View {
    var viewModel = CalendarViewModel(year: 2024)

    var body: some View {
        List(1..<13, id: \.self) { monthNumber in
            MonthView(viewModel: viewModel.monthViewModel(monthNumber))
        }
    }
}

// MARK: - Preview

#Preview {
    CalendarView()
}
