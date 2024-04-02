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
    let selectable: Bool

    init(text: String = "",
         type: CellType,
         selectable: Bool = false) {
        self.text = text
        self.type = type
        self.selectable = selectable
    }

    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(isSelected ? CellType.selected.bgColor : type.bgColor)
            .padding(4)
            .onTapGesture {
                if selectable {
                    isSelected = !isSelected
                }
            }
    }
}

// MARK: - DateType

extension CalendarCellView {

    enum CellType {
        case day
        case week
        case date
        case selected

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
            }
        }
    }
}
