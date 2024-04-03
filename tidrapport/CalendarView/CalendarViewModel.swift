//
//  CalendarViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

struct CalendarViewModel {
    var year: Int
    private var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "en_GB") // Monday is considered the first day of the week in the UK
        return cal
    }

    func monthViewModel(_ monthNumber: Int) -> MonthViewModel {
        let month = calendar.date(from: DateComponents(year: year, month: monthNumber)) ?? Date()
        return MonthViewModel(month: month)
    }
    
    func dataForYear(_ year: Int) -> [CalendarData] {
        var calendarDataList = [CalendarData]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let startDate = dateFormatter.date(from: "\(year)/01/01")!
        let endDate = dateFormatter.date(from: "\(year)/12/31")!
        for date in DateInterval(start: startDate, end: endDate).days {
            let dateString = dateFormatter.string(from: date)
            let calendarData = CalendarData(date: dateString,
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
