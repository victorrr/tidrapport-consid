//
//  CalendarCellView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct CalendarCellView: View {
    @State var isSelected = false
    let text: String
    var type: CellType

    init(text: String = "",
         type: CellType,
         selectable: Bool = false) {
        self.text = text
        self.type = type
    }

    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(isSelected ? CellType.selected.bgColor : type.bgColor)
            .padding(4)
            .onTapGesture {
                if type.isSelectable {
                    isSelected = !isSelected
                }
            }
    }
}

// MARK: - DateType

extension CalendarCellView {

    enum CellType: CaseIterable {
        case day
        case week
        case date
        case selected
        case reported
        case submitted

        var bgColor: Color {
            switch self {
            case .day:
                return .brown
            case .week:
                return .gray
            case .date:
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

// MARK: - Preview

#Preview {
    Group {
        ForEach(CalendarCellView.CellType.allCases, id: \.self) { type in
            CalendarCellView(text: type.name, type: type)
        }
    }
}
