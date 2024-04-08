//
//  CalendarCellView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct CalendarCellView: View {
    @ObservedObject var viewModel: CalendarCellViewModel

    init(viewModel: CalendarCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.text ?? "")
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(viewModel.isSelected ? CalendarCellViewModel.CellType.selected.bgColor : viewModel.type.bgColor)
            .padding(4)
//            .onTapGesture {
//                if type.isSelectable {
//                    isSelected.toggle()
//                }
//            }
    }
}

// MARK: - Preview

#Preview {
    Group {
        ForEach(CalendarCellViewModel.CellType.allCases, id: \.self) { type in
            let viewModel = CalendarCellViewModel(text: type.name, type: type)
            return CalendarCellView(viewModel: viewModel)
        }
    }
}
