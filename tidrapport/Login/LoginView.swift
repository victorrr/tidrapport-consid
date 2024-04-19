//
//  LoginView.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-18.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        if viewModel.isLoading || viewModel.isSuccessful || viewModel.isError {
            activity
        } else {
            form
        }
    }
}

// MARK: - Private

private extension LoginView {

    var form: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Inloggningsuppgifter")) {
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        SecureField("Lösenord", text: $viewModel.password)
                    }
                }
                .navigationBarTitle("Tidrapport")
                Button(action: {
                    viewModel.login()
                }) {
                    Text("Logga in")
                }
                .disabled(!viewModel.inputIsValid)
            }
        }
    }

    var activity: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.isSuccessful {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.system(size: 100))
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Börja rapportera tid")
                        .padding()
                }
            } else if viewModel.isError {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 100))
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Försök igen")
                }
            }
        }
    }

}

#Preview {
    LoginView()
}
