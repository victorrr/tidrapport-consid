//
//  CalendarCellViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-05.
//

import SwiftUI

final class CalendarCellViewModel: ObservableObject {
    @Published var isSelected = false
    @Published var timeEntry: TimeEntry?
    @Published var isInformationSheetPresented = false
    let text: String?
    let type: CellType
    let date: Date?
    private let isHoliday: Bool
    private let isWeekend: Bool

    init(text: String? = nil,
         type: CellType,
         date: Date? = nil,
         isHoliday: Bool = false,
         isWeekend: Bool = false) {
        self.text = text
        self.type = type
        self.date = date
        self.isHoliday = isHoliday
        self.isWeekend = isWeekend
    }

    var dateString: String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    var isSelectableDate: Bool {
        type.isSelectable && !isHoliday && !isWeekend && timeEntry == nil
    }

    var background: Color {
        if date == nil {
            return type.bgColor
        }
        if isSelected {
            return Color(hex: "27ae60")
        }
        if isWeekend {
            return Color(hex: "f3f3f3")
        }
        if isHoliday  {
            return Color(hex: "ef5350")
        }
        if timeEntry?.article.name == "Semester" {
            return Color(hex: "4dd0e1")
        }
        if timeEntry?.article.name == "Föräldraledig" {
            return Color(hex: "16a085")
        }
        if timeEntry?.isSubmitted == true {
            return Color(hex: "27ae60")
        }
        return .clear
    }

    var shouldShowInformation: Bool {
        if type.isSelectable && timeEntry != nil {
            if timeEntry?.isSubmitted == false {
                return false // Det gå i dagsläget inte att ändra en dag som man påbörjat att rapportera på
            }
            return true
        }
        return false
    }

    var extraInfo: String? {
        if isWeekend {
            return "Vald dag är på en helg"
        }
        if isHoliday {
            return "Vald dag är på en helgdag"
        }
        return nil
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

        var bgColor: Color {
            switch self {
            case .weekDayName:
                return Color(hex: "f3f3f3")
            case .week:
                return Color(hex: "f3f3f3")
            case .date, .emptyDate:
                return .clear
            }
        }

        var isSelectable: Bool {
            self == .date
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
            }
        }
    }
}
