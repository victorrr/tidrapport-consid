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
                loading
            } else if viewModel.isSuccessful {
                success
            } else if viewModel.isError {
                error
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

    var loading: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Skickar...")
        }
    }

    var success: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 100))
            Button {
                closeAction?()
            } label: {
                Text("Klar")
            }
        }
    }

    var error: some View {
        VStack(spacing: 16) {
            Image(systemName: "xmark.octagon.fill")
                .foregroundColor(.red)
                .font(.system(size: 100))
            Button {
                closeAction?()
            } label: {
                Text("Försök igen")
            }
        }
    }

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
