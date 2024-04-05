//
//  CalendarViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

final class CalendarViewModel {
    var year: Int
    lazy var monthViewModels: [MonthViewModel] = (1..<13).compactMap(createMonthViewModel)

    init(year: Int) {
        self.year = year
    }

    func monthViewModel(_ monthNumber: Int) -> MonthViewModel {
        monthViewModels[monthNumber-1]
    }

    func dataForYear(_ year: Int) -> [ProjectData] {
        var calendarDataList = [ProjectData]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let startDate = dateFormatter.date(from: "\(year)/01/01")!
        let endDate = dateFormatter.date(from: "\(year)/12/31")!
        for date in DateInterval(start: startDate, end: endDate).days {
            let dateString = dateFormatter.string(from: date)
            let calendarData = ProjectData(id: "0",
                                            date: dateString,
                                            hours: "",
                                            project: "",
                                            description: "",
                                            isBillable: false,
                                            isSubmitted: false)
            calendarDataList.append(calendarData)
        }
        return calendarDataList
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
        calendar.date(from: DateComponents(year: year, month: monthNumber)).map { MonthViewModel(month: $0) }
    }
}
