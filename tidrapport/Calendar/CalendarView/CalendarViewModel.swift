//
//  CalendarViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-26.
//

import Foundation

final class CalendarViewModel: ObservableObject {
    @Published var isPresentingLoginView = true
    private var year: Int
    private var client: TimeClient = TimeClient()
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

    func fetchReportedTime() {
        let fromDate = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        let toDate = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
        client.fetchReportedTime(fromDate: fromDate, toDate: toDate) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reportedTime):
                updateReportedTime(reportedTime)
            case .failure(let error):
                print(error)
            }
        }
    }

    func refresh() {

    }
}

// MARK: - Private

private extension CalendarViewModel {

    var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "en_GB") // Monday is considered the first day of the week in the UK
        return cal
    }

    var holidays: [Date] {
        [
            (1, 1),
            (1, 6),
            (4, 19),
            (4, 21),
            (6, 6),
            (6, 22),
            (11, 2),
            (12, 25),
            (12, 26)
        ].map {
            DateComponents(year: year, month: $0, day: $1)
        }.compactMap {
            calendar.date(from: $0)
        }
    }

    func isHoliday(_ date: Date) -> Bool {
        holidays.contains { holiday in
            calendar.isDate(date, inSameDayAs: holiday)
        }
    }

    func isWeekend(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7
    }

    func createMonthViewModel(_ monthNumber: Int) -> MonthViewModel? {
        calendar.date(from: DateComponents(year: year, month: monthNumber)).map {
            let vm = MonthViewModel(month: $0)
            vm.addCellViewModels(isHoliday: isHoliday, isWeekend: isWeekend)
            return vm
        }
    }

    func updateReportedTime(_ reportedTime: [TimeEntry]) {
        monthViewModels.forEach { $0.updateReportedTime(reportedTime) }
    }
}
