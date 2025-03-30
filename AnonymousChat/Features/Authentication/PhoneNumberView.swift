
//  Untitled.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @State private var phoneNumber = ""
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        
        VStack {
            VStack {
                TextField("380..", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
            }
            .padding(.horizontal, 64)
            
            Button("Confirm") {
                auth.goToCodeScreen(with: phoneNumber)
                print("")
            }
            .padding(.top, 32)
            
        }
    }
}
