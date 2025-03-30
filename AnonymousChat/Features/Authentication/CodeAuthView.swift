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
    @Environment(\.dismiss) var dismiss
    @State private var code = ""
    @State private var isResendAllowed = false
    @State private var resendTimer: Int = 60
    @State private var timer: Timer? = nil
    private let maxDigits = 6
    
    var body: some View {
        VStack {
            Text("SMS will be sent to: \(auth.currentPhoneNumber)")
            HStack {
                TextField("Your code from SMS", text: $code)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    .onChange(of: code) { newValue, _ in
                        let filtered = newValue.filter { $0.isNumber }
                        if filtered.count <= maxDigits {
                            code = filtered
                        } else {
                            code = String(filtered.prefix(maxDigits))
                        }
                    }
                
            }
            Button("Verify") {
                Task {
                    await auth.verifyCode(code)
                }
            }
            .buttonStyle(.borderedProminent)
            .cornerRadius(16)
            Button(action: {
                resendCode()
            }) {
                Text(
                    isResendAllowed ? "Resend again" : "Resend will avaliable in \(resendTimer) seconds"
                )
            }
            .frame(maxWidth: .infinity)
            .disabled(!isResendAllowed)
            .foregroundColor(isResendAllowed ? .blue : .gray)
        }
        .padding()
        .onAppear {
            startResendTimer()
            
        }
        .padding(.horizontal, 64)
        
    }
    func resendCode() {
        Task {
            print("RESENDING CODE AGAIN")
            await auth.sendCode(phoneNumber: auth.currentPhoneNumber)
            startResendTimer()
        }
            
        
    }

    func startResendTimer() {
        isResendAllowed = false
        resendTimer = 60
        timer?.invalidate() 
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            resendTimer -= 1
            if resendTimer <= 0 {
                isResendAllowed = true
                t.invalidate()
            }
        }
    }
}
