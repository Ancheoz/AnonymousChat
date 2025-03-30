//
//  ViewModel.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 29.03.2025.
//
import SwiftUI


@MainActor
class ViewModel: ObservableObject {
    
    @Published var auth = AuthViewModel()
    @Published var chat = ChatViewModel()
    
}
