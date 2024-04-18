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
                    Section {
                        TextField("Email", text: $viewModel.email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                        SecureField("Lösenord", text: $viewModel.password)
                    }
                    Section {
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Logga in")
                        }
                    }
                }
                .navigationBarTitle("Logga in")
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
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Klar")
                        .padding()
                }
            } else if viewModel.isError {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
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
