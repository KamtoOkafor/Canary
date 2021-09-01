//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 3/12/21.
//

import SwiftUI

@main
struct FinanceTrackerApp: App {
    @StateObject private var subscriptionList = SubscriptionList()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(subscriptionList)
        }
    }
}
