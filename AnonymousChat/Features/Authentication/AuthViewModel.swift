//
//  LoginViewModel.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var authState: AuthState = .enterPhone
    @Published var currentPhoneNumber: String = ""
    @Published var verificationID: String? = nil
    @Published var isLoggedIn = false {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    @Published var phoneNumber: String = "" {
        didSet {
            UserDefaults.standard.set(phoneNumber, forKey: "savedPhone")
        }
    }
    init() {
        phoneNumber = UserDefaults.standard.string(forKey: "savedPhone") ?? ""
        isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn {
            authState = .loggedIn
        }
    }
    
    func isValidPhoneNumber(_ number: String) -> Bool {
        let pattern = "^\\+380\\d{9}$"
        return number.range(of: pattern, options: .regularExpression) != nil
    }
    
    func sendCode(phoneNumber: String) async {
        guard isValidPhoneNumber(phoneNumber) else {
            print("Wrong phone format \(phoneNumber)")
            return
        }

        do {
            print("Sending code to: \(phoneNumber)")
            let result = try await PhoneAuthProvider.provider()
                .verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            self.verificationID = result
            self.authState = .enterCode
            print("Code sent, verificationID: \(result)")
            self.phoneNumber = phoneNumber
        } catch {
            print("Error sending code: \(error.localizedDescription)")
            print("Full error: \(error)")
            self.phoneNumber = ""
        }
    }

    
    func verifyCode(_ code: String) async {
        guard let verificationID = verificationID else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        do {
            let _ = try await Auth.auth().signIn(with: credential)
            self.authState = .loggedIn
            
            self.isLoggedIn = true
            print("Authorization sucessful!")
        } catch {
            print("Authorization error!")
        }
    }
    
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            authState = .enterPhone
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            print("Log Out")
        } catch {
            print("error log out")
        }
    }
}
