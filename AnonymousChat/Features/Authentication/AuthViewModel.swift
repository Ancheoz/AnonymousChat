//
//  LoginViewModel.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

@MainActor
class AuthViewModel: ObservableObject {
    @Published var authState: AuthState = .enterPhone
    @Published var phoneNumber: String = ""
    @Published var isLoggedIn = false
    @Published var currentPhoneNumber: String = ""
    
    
    func goToCodeScreen(with phone: String) {
        authState = .enterCode
        print(authState.self)
        print(#function)
    }

    
    func login(withPhone phone: String,_ code: String) async {
        do {
            print("Login in process...")
            try await Task.sleep(for: .seconds(1))
            self.isLoggedIn = true
            
            self.authState = .loggedIn
            print("Login complete. isLoggedIn: \(self.isLoggedIn), state: \(self.authState)")
            
            
        } catch {
            print("AuthViewModel: Authentication error")
        }
    }
    
    func logOut() {
        authState = .enterPhone
        phoneNumber = ""
        print (authState, phoneNumber)
    }
}
