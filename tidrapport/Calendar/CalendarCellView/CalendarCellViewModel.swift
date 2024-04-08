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

    init(text: String? = nil,
         type: CellType) {
        self.text = text
        self.type = type
    }
}

// MARK: - CellType

extension CalendarCellViewModel {

    enum CellType: CaseIterable {
        case day
        case week
        case date
        case emptyDate
        case selected
        case reported
        case submitted

        var bgColor: Color {
            switch self {
            case .day:
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
            case .day:
                return "Day"
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
