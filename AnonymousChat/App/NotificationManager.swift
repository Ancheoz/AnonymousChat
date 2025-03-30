//
//  NotificationManager.swift
//  AnonymousChat
//
//  Created by Oleksandr Prytchyn on 31.03.2025.
//

import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            completion(granted)
        }
    }

    func sendWelcomeNotification() {
        let content = UNMutableNotificationContent()
        content.title = "AnonymousChat"
        content.body = "Welcome to AnonymousChat! Enjoy!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("UNUserNotificationCenter: failed to show notification — \(error.localizedDescription)")

            }
        }
    }
    
    func configureNotifications() {
        requestAuthorization { [weak self] granted in
            guard granted else {
                print("User hasn't granted access to notifications")
                return
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self?.sendWelcomeNotification()
            }
        }
    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
