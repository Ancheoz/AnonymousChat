//
//  SceneDelegate.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 29.03.2025.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let viewModel = ViewModel()
    
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView:
                                                            NavigationStack {
            Group {
                RootView()
                    .environmentObject(viewModel)
                    .environmentObject(viewModel.auth)
                    .environmentObject(viewModel.chat)
            }
        }
        )
        
        self.window = window
        window.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print(#function)
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        print(#function)
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print(#function)
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print(#function)
    }
    
    
}

