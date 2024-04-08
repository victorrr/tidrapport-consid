//
//  AddTimeView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-03.
//

import SwiftUI

struct AddTimeView: View {
    let viewModel: AddTimeViewModel

    var body: some View {
        VStack {
            Text("Valda datum")
                .font(.title)
                .padding(.top, 8)
            List(viewModel.days, id: \.self) { day in
                Text(day)
            }
        }
    }
}

#Preview {
    let viewModel = AddTimeViewModel(selectedDates: [])
    return AddTimeView(viewModel: viewModel)
}
