//
//  CalendarView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-25.
//

import SwiftUI

struct CalendarView: View {
    var viewModel = CalendarViewModel()
    @State private var isPresentingAddTimeView: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List(1..<13, id: \.self) { monthNumber in
                    MonthView(viewModel: viewModel.monthViewModel(monthNumber))
                }
                addTimesButton(x: geometry.size.width - 80,
                               y: geometry.size.height - 80)
            }
            .sheet(isPresented: $isPresentingAddTimeView) {
                addTimeView
            }
        }
    }
}

// MARK: - Private

private extension CalendarView {

    var addTimeView: some View {
        let addTimeViewModel = AddTimeViewModel(selectedDates: viewModel.selectedDates)
        addTimeViewModel.prefillProjectData()
        return AddTimeView(viewModel: addTimeViewModel)
            .onDisappear {
                isPresentingAddTimeView = false
            }
    }

    func addTimesButton(x: CGFloat, y: CGFloat) -> some View {
        Button {
            isPresentingAddTimeView.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
        }
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .position(x: x, y: y)
    }
}

// MARK: - Preview

#Preview {
    CalendarView()
}
