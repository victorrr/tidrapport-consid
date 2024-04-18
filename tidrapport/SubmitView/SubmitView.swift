//
//  SubmitView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-15.
//

import SwiftUI

struct SubmitView: View {
    @ObservedObject var viewModel: SubmitViewModel
    var closeAction: (() -> Void)?

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.isSuccessful {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                Button {
                    closeAction?()
                } label: {
                    Text("Klar")
                        .padding()
                }
            } else if viewModel.isError {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Button {
                    closeAction?()
                } label: {
                    Text("Försök igen")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.submitData()
        }
    }
}

// MARK: - Private

private extension SubmitView {


}

#Preview {
    let projectData = ProjectData(id: "1",
                                  hours: 8,
                                  article: "",
                                  customer: "",
                                  project: "",
                                  activity: "",
                                  errandNumber: "",
                                  description: "",
                                  isSubmitted: false)
    let viewModel = SubmitViewModel(projectData: projectData, dates: [Date()])
    return SubmitView(viewModel: viewModel)
}
