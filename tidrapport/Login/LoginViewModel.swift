//
//  LoginViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-18.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var isSuccessful = false
    @Published var isError = false

    func login() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isLoading = false
            self.isSuccessful = true
        }
    }
}

