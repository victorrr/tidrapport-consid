//
//  CalendarView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-03-25.
//

import SwiftUI

struct CalendarView: View {
    var viewModel = CalendarViewModel(year: 2024)
    @State private var isButtonPressed = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    List(1..<13, id: \.self) { monthNumber in
                        MonthView(viewModel: viewModel.monthViewModel(monthNumber))
                    }

                    NavigationLink(destination: NewView(), isActive: $isButtonPressed) {
                        EmptyView()
                    }

                    Button(action: {
                        self.isButtonPressed = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .padding()
                    }
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .position(x: geometry.size.width - 80, y: geometry.size.height - 80)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    CalendarView()
}
