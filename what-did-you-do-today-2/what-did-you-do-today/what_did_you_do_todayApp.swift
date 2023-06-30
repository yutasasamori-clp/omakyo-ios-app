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
    // 追加 2 end
}

// 追加 1
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
}
