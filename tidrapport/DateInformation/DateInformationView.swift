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
        NavigationView {
            List {
                if let extraInfo = viewModel.extraInfo {
                    Text(extraInfo)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                ForEach(viewModel.informationStrings ?? [], id: \.self) { informationString in
                    Text(informationString)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Stäng")
                }
            }
        }
    }
}

#Preview {
    DateInformationView(viewModel: DateInformationViewModel(timeEntry: nil))
}
