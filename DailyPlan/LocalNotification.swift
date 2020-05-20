//
//  LocalNotification.swift
//  DailyPlan
//
//  Created by zhaoyang on 2020/5/19.
//  Copyright © 2020 zhaoyang. All rights reserved.
//

import UIKit
import UserNotifications

class LocalNotification: NSObject {

    class func notificationRegister() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { granted, error in
            if granted {
                print("用户允许通知")
            }
        }
        
    }
    
    class func localNotification() {
        // 通知内容
        let content = UNMutableNotificationContent()
        let date = DailyNumber.getDateFormatString()
        let number = DailyNumber.insertDailyRandomNumber(date: DailyNumber.getDateFormatString())
        let message = String(number)
        content.title = "Daily Notification"
        content.body = "Daily Random Number (\(date)): ".appending(message)
        content.badge = 1
        
        // 发送触发
        // 每天 7点 推送
        let components = DateComponents(hour: 7)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        // 请求标识符
        let requestIdentifier = "com.zdayer.ZdayerDaily.localNotification"
        
        // 发送请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        
        // 添加到发送中心
        UNUserNotificationCenter.current().add(request) { error in
            if error == nil {
                print("Daily Notification scheduled: \(requestIdentifier)")
                let tempDic = NSMutableDictionary(dictionary: DailyNumber.fetchCache())
                tempDic.setValue(number, forKey: DailyNumber.getDateFormatString())
                tempDic.write(toFile: DailyNumber.cachePath(), atomically: true)
            }
        }
    }
    
    
}
