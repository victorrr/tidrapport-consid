//
//  DateInformationView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-19.
//

import SwiftUI

struct DateInformationView: View {
    var viewModel: DateInformationViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Stäng")
                    }
                }
                Text(viewModel.informationString ?? "Inte matchad till ett datum")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(20)
            Spacer()
        }
    }
}

#Preview {
    DateInformationView(viewModel: DateInformationViewModel(timeEntry: nil))
}
