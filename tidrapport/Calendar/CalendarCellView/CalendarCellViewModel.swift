//
//  CalendarCellViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-05.
//

import Foundation
import SwiftUI

final class CalendarCellViewModel: ObservableObject {
    @Published var isSelected = false
    let text: String?
    let type: CellType
    let date: Date?
    let holidays: [Date] = [
        Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 6))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 19))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 21))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 6))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 22))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 2))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 25))!,
        Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 26))!
    ]

    init(text: String? = nil,
         type: CellType,
         date: Date? = nil) {
        self.text = text
        self.type = type
        self.date = date
    }

    var background: Color {
        if isSelected {
            return .red
        }
        if isHoliday || isWeekend {
            return .yellow
        }
        return .clear
    }
}

private extension CalendarCellViewModel {

    var isHoliday: Bool {
        guard let date = date else { return false }
        let calendar = Calendar.current
        return holidays.contains { holiday in
            calendar.isDate(date, inSameDayAs: holiday)
        }
    }

    var isWeekend: Bool {
        guard let date = date else { return false }
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7
    }
}

extension CalendarCellViewModel: Hashable {

    static func == (lhs: CalendarCellViewModel, rhs: CalendarCellViewModel) -> Bool {
        lhs.text == rhs.text && 
        lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
        hasher.combine(type)
    }
}

// MARK: - CellType

extension CalendarCellViewModel {

    enum CellType: CaseIterable {
        case weekDayName
        case week
        case date
        case emptyDate
        case selected
        case reported
        case submitted

        var bgColor: Color {
            switch self {
            case .weekDayName:
                return .brown
            case .week:
                return .gray
            case .date, .emptyDate:
                return .clear
            case .selected:
                return .red
            case .reported:
                return .yellow
            case .submitted:
                return .green
            }
        }

        var isSelectable: Bool {
            switch self {
            case .date, .selected:
                return true
            default:
                return false
            }
        }

        var name: String {
            switch self {
            case .weekDayName:
                return "Week day name"
            case .week:
                return "Week"
            case .date:
                return "Date"
            case .emptyDate:
                return "Empty Date"
            case .selected:
                return "Selected"
            case .reported:
                return "Reported"
            case .submitted:
                return "Submitted"
            }
        }
    }
}
