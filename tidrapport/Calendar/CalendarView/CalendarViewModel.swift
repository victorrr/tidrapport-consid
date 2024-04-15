//
//  CalendarViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

final class CalendarViewModel {
    private var year: Int
    lazy var monthViewModels: [MonthViewModel] = (1..<13).compactMap(createMonthViewModel)

    init(year: Int? = nil) {
        self.year = year ?? Calendar.current.component(.year, from: Date())
    }

    var selectedDates: [Date] {
        monthViewModels.flatMap { $0.selectedDates }
    }

    func monthViewModel(_ monthNumber: Int) -> MonthViewModel {
        monthViewModels[monthNumber-1]
    }
}

// MARK: - Private

private extension CalendarViewModel {

    var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "en_GB") // Monday is considered the first day of the week in the UK
        return cal
    }

    func createMonthViewModel(_ monthNumber: Int) -> MonthViewModel? {
        calendar.date(from: DateComponents(year: year, month: monthNumber)).map {
            let vm = MonthViewModel(month: $0)
            vm.addCellViewModels()
            return vm
        }
    }
}
