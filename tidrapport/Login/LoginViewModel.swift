//
//  LoginViewModel.swift
//  tidrapport
//
//  Created by Victor Rendon on 2024-04-18.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = UserDefaults.standard.string(forKey: Key.email) ?? ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var isSuccessful = false
    @Published var isError = false

    func login() {
        UserDefaults.standard.setValue(email, forKey: Key.email)
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            self.isSuccessful = true
        }
    }

    var inputIsValid: Bool {
        !email.isEmpty && !password.isEmpty && isValidEmail
    }
}

// MARK: - Key

private extension LoginViewModel {

    struct Key {
        static let email = "email"
    }
}

// MARK: - Private

private extension LoginViewModel {

    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

