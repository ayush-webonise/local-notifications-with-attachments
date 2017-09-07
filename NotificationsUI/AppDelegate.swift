
//  AppDelegate.swift
//  NotificationsUI

import UIKit
import UserNotifications

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        return true
    }
    
    func scheduleNotification(at date: Date) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month,
                                           day: components.day, hour: components.hour, minute: components.minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        //create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Lunch Reminder"
        content.body = "Just a reminder to eat your lunch at 3:00 pm"
        content.sound = UNNotificationSound.default()
        
        //add an attachment to the notification
        if let path = Bundle.main.path(forResource: "rotlu", ofType: "gif") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        
        //create a notification request
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
}
