//
//  LocalNotificationHelper.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/28/24.
//

import Foundation
import SwiftUI

class LocalNotificationHelper {
    static let shared = LocalNotificationHelper()

    private init() { }

    func pushNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "오늘도 금연에 다가가 보아요!"
        notificationContent.body = "하루에 흡연 횟수 1번씩만 줄이기 🫡"

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.hour = 7
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            } else {
            }
        }
    }
}
