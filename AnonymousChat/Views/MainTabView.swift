//
//  TabView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var showSettings = false
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "bell.badge")
                        .font(.system(size: 24))
                    Spacer()
                    VStack {
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 24))
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            TabView {
                
                ChatView()
                    .environmentObject(auth)
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                        Text("Chats")
                    }
                FeedView()
                    .environmentObject(auth)
                    .tabItem {
                        Image(systemName: "sunglasses.fill")
                        Text("City news")
                    }
                ProfileView()
                    .environmentObject(auth)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }
        
        .navigationDestination(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(auth)
        }
    }
    
}
