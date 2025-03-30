//
//  SettingsView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Your phone number: \(auth.phoneNumber)")
            Button("Change") {
                // ACTION TO CHANGE
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .cornerRadius(16)
            Button {
                 auth.logOut()
                dismiss()
            } label: {
                Text("Log out")
                
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .cornerRadius(16)
        }
        
    }
}
