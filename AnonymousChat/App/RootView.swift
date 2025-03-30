//
//  ContentView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 29.03.2025.
//

import SwiftUI

enum AuthState: Equatable {
    case enterPhone
    case enterCode
    case loggedIn
}

@MainActor
struct RootView: View {
    @EnvironmentObject var auth: AuthViewModel
    
    @ViewBuilder
    var body: some View {
        Group {
            switch auth.authState {
            case .enterPhone:
                PhoneNumberView()
                    .environmentObject(auth)
            case .enterCode:
                CodeAuthView()
                    .environmentObject(auth)
            case .loggedIn:
                MainTabView()
                    .environmentObject(auth)
            }
        }
    }
}


