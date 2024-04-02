//
//  DateView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct DateView: View {
    @State var isSelected = false
    let dateString: String
    var dateType: DateType
    let selectable: Bool

    init(dateString: String = "", dateType: DateType, selectable: Bool = false) {
        self.dateString = dateString
        self.dateType = dateType
        self.selectable = selectable
    }

    var body: some View {
        Text(dateString)
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(isSelected ? DateType.selected.bgColor : dateType.bgColor)
            .padding(4)
            .onTapGesture {
                if selectable {
                    isSelected = !isSelected
                }
            }
    }
}

// MARK: - DateType

extension DateView {

    enum DateType {
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
