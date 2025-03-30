//
//  SettingsView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack {
            Button {
                 model.auth.logOut()
                dismiss()
            } label: {
                Text("Log out")
                
            }
            .buttonBorderShape(.circle)
            .padding()
            .background(Color.gray)
            .cornerRadius(16)

        }
    }
}
