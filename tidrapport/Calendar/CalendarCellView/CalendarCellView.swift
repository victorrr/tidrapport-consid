//
//  CalendarCellView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-27.
//

import SwiftUI

struct CalendarCellView: View {
    @ObservedObject var viewModel: CalendarCellViewModel
    @State private var isInformationSheetPresented = false

    var body: some View {
        Text(viewModel.text ?? "")
            .multilineTextAlignment(.leading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(viewModel.isSelected ? CalendarCellViewModel.CellType.selected.bgColor : viewModel.background)
            .padding(4)
            .onLongPressGesture {
                isInformationSheetPresented = true
            }
            .sheet(isPresented: $isInformationSheetPresented, content: {
                let vm = DateInformationViewModel(timeEntry: viewModel.timeEntry)
                return DateInformationView(viewModel: vm)
            })
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
