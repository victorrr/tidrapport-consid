//
//  CalendarView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-25.
//

import SwiftUI

struct CalendarView: View {
    var viewModel = CalendarViewModel(year: 2024)
    @State private var isButtonPressed: Bool = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    List(1..<13, id: \.self) { monthNumber in
                        MonthView(viewModel: viewModel.monthViewModel(monthNumber))
                    }

                    Button(action: {
                        isButtonPressed = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()
                    }
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .position(x: geometry.size.width - 80, 
                              y: geometry.size.height - 80)
                    .navigationDestination(isPresented: $isButtonPressed) {
                        AddTimeView()
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CalendarView()
}
