//
//  ChatView.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 30.03.2025.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var showSettings = false
    var body: some View {
        VStack {
            HStack {
                VStack {
                }
                .frame(width: 24, height: 24)
                Spacer()
                VStack {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .buttonStyle(.plain)

                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .fullScreenCover(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(viewModel)
        }
    }
}
