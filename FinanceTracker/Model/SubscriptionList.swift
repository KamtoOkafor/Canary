//
//  SubscriptionList.swift
//  FinanceTracker
//
//  Created by Keegan West on 3/18/21.
//

import UserNotifications
import Foundation

class SubscriptionList: ObservableObject {
    @Published var monthlyList: [Subscription]
    @Published var yearlyList: [Subscription]
    @Published var totalMonthlyCost: Double
    @Published var totalYearlyCost: Double
    @Published var notificationsAreOn: Bool
    @Published var overallCost: Double = 0.0
    
    init() {
        monthlyList = []
        yearlyList = []
        totalMonthlyCost = 0
        totalYearlyCost = 0
        notificationsAreOn = false
    }
    
    func calculateTotal() {
        overallCost = totalYearlyCost + totalMonthlyCost
    }
    
    func addSub(_ sub: Subscription, _ yearly: Bool) {
        if yearly {
            yearlyList.append(sub)
            totalYearlyCost += Double(sub.cost) ?? 0.0
        } else {
            monthlyList.append(sub)
            totalMonthlyCost += Double(sub.cost) ?? 0.0
        }
        
        calculateTotal()
        
        print ("subName \(sub.name)")
        print("monthly list count \(monthlyList.count)")
        
        if notificationsAreOn {
            registerNotification(sub: sub, isYearly: yearly)
        }
    }
    
    func turnNotificationsOnOrOff(turnOn: Bool) {
        if turnOn {
            notificationsAreOn = true
            for monthlySub in monthlyList {
                registerNotification(sub: monthlySub, isYearly: false)
            }
            
            for yearlySub in yearlyList {
                registerNotification(sub: yearlySub, isYearly: true)
            }
        } else {
            notificationsAreOn = false
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    func registerNotification(sub: Subscription, isYearly: Bool) {
        let notificationCenter = UNUserNotificationCenter.current()
            
        let content = UNMutableNotificationContent()
            
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
            
        let uuidString = UUID().uuidString
            
        if(isYearly == false) {
            content.title = sub.name + " subscription due soon"
            content.body = sub.cost + "$ due in a week"
                
            dateComponents.hour = 12
            dateComponents.day = Calendar.current.dateComponents([.day], from: sub.datePurchased).day
                
            if dateComponents.day! > 7 {
                dateComponents.day! -= 7
            } else {
                dateComponents.day! += 21
            }
        } else {
            content.title = sub.name + " subscription due soon"
            content.body = "$" + sub.cost + " due in a month"
            dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current
            dateComponents.day = 1
            dateComponents.hour = 12
            dateComponents.month = Calendar.current.dateComponents([.month], from: sub.datePurchased).month
                
            if dateComponents.month! == 1 {
                dateComponents.month! = 12
            } else {
                dateComponents.month! -= 1
            }
        }

        /*dateComponents.month = 4
        dateComponents.day = 30
        dateComponents.hour = 10
        dateComponents.minute = 29*/
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("there was an error")
            }
        }
    }
}
