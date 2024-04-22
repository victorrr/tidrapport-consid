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
            Text("Tidrapporten har skickats!")
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
    let timeEntry = TimeEntry(id: 0, date: "", hours: 8, article: Article(id: 0, name: ""), customer: Customer(id: 0, name: ""), project: Project(id: 0, name: ""), activity: "", caseNumber: "", description: "", isSubmitted: true, empId: "")

    let viewModel = SubmitViewModel(projectData: timeEntry, dates: [Date()])
    return SubmitView(viewModel: viewModel)
}
