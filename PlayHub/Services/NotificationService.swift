//
//  NotificationService.swift
//  PlayHub
//
//  Created by Amaya Mahavithane on 2026-07-06.
//

import Foundation
import UserNotifications

class NotificationService {

    static let shared = NotificationService()

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { _,_ in }
    }

    func schedule(hour: Int, minute: Int) {

        let content = UNMutableNotificationContent()
        content.title = "Daily Challenge"
        content.body = "Come back and beat your high score!"
        content.sound = .default

        var date = DateComponents()
        date.hour = hour
        date.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        let request = UNNotificationRequest(
            identifier: "DailyChallenge",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        UNUserNotificationCenter.current().add(request)
    }
}
