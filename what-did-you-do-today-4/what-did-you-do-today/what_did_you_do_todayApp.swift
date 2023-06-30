//
//  what_did_you_do_todayApp.swift
//  what-did-you-do-today
//
//  Created by Yuta Sasamori on 2023/06/29.
//

import SwiftUI

@main
struct what_did_you_do_todayApp: App {
    @UIApplicationDelegateAdaptor (AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    // 追加 2 start
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            // 追加2
            VStack {
                        Button {
                            Task {
                                await notification()
                            }
                        } label: {
                            Text("通知を開始")
                        }
                    }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    // 通知許可を送信
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
            }
        }
        return true
    }
    
    // 追加 1 start
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping ()
                                -> Void) {
        if response.actionIdentifier == "reply.action" {
            if let textResponse = response as? UNTextInputNotificationResponse {
                let replyText = textResponse.userText

                let context = PersistenceController.shared.container.viewContext
                let newItem = Item(context: context)
                newItem.content = replyText
                newItem.timestamp = Date()
                do {
                    try context.save()
                    print("Reply saved to Core Data.", context)
                } catch {
                    print("Failed to save reply to Core Data: \(error)")
                }

            }
        }

        completionHandler()
    }
    // 追加 1 end
}
