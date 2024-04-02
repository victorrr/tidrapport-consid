//
//  CalendarViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

struct CalendarViewModel {
    var selectedYear: Int = 2024
    var calendar = Calendar.current

    func dateForMonth(_ month: Int) -> Date {
        calendar.date(from: DateComponents(year: selectedYear, month: month))!
    }
    
    func calendarDataForYear(year: Int) -> [CalendarData] {
        var calendarDataList = [CalendarData]()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        let calendar = Calendar.current
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
