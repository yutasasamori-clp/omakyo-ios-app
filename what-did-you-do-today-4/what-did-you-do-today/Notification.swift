import UserNotifications

//通知を管理
public func notification() async {
    //   追加 1 start
    func setupReplyAction() {
        let replyAction = UNTextInputNotificationAction(
            identifier: "reply.action",
            title: "Reply on message",
            textInputButtonTitle: "Send",
            textInputPlaceholder: "Input text here"
        )

        let replyCategory = UNNotificationCategory(
            identifier: "reply.category",
            actions: [replyAction],
            intentIdentifiers: [],
            options: []
        )

        UNUserNotificationCenter.current().setNotificationCategories([replyCategory])
    }
    
    do {
        setupReplyAction()
        
        let content = UNMutableNotificationContent()
        content.title = "Reply Notification"
        content.body = "It's time to reply!"
        content.categoryIdentifier = "reply.category"

        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        try await UNUserNotificationCenter.current().add(request)
    } catch {
            print(error)
    }
}
