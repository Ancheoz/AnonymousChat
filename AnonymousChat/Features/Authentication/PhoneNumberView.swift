
//  Untitled.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct PhoneNumberView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    @FocusState private var focus: Bool
    @State private var showAlert = false
    @State private var userInput = ""
    private let prefix = "+380"
    @State private var fullNumber = ""
    private let maxDigits = 9
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(prefix)
                        .foregroundColor(.gray)
                    
                    TextField("XX XXX XXXX", text: $userInput)
                        .keyboardType(.numberPad)
                        .focused($focus)
                        .onChange(of: userInput) { newValue, _ in
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count <= maxDigits {
                                userInput = filtered
                            } else {
                                userInput = String(filtered.prefix(maxDigits))
                            }
                        }
                        
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
            }
            .padding(.horizontal, 64)
            
            Button("Send code") {
                let fullNumber = prefix + userInput
                if fullNumber.count == 13 {
                    Task {
                        await auth.sendCode(phoneNumber: fullNumber)
                    }
                } else {
                    showAlert = true
                }
                
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(16)
            .padding(.top, 32)
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focus = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"),
                  message: Text("Your number must contain 13 symbols"),
                  dismissButton: .default(Text("OK")))
        }
        
    }
}
