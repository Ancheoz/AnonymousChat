//
//  CodeAuthView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct CodeAuthView: View {
    
    @State var enteredCode: String = ""
    @EnvironmentObject var auth: AuthViewModel
    @State private var phoneNumber: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Entered phone number: \(auth.currentPhoneNumber)")
            TextField("Entered code", text: $enteredCode)
            Button("Confirm") {
                Task {
                        await auth.login(withPhone: auth.currentPhoneNumber, enteredCode)
                    }
            }
        }
    }
}
