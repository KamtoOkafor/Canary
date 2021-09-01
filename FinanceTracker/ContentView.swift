//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 3/12/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var subscriptionList: SubscriptionList
    
    var body: some View {
        TabView() {
            HomeView().environmentObject(subscriptionList)
                .tag(0)
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                        .padding()
            }
            SubscriptionView().environmentObject(subscriptionList)
                .tag(1)
                .tabItem {
                    Text("Subscriptions")
                    Image(systemName: "note.text")
                        .resizable().aspectRatio(contentMode: .fit)
                        .padding()
            }
            CameraView()
                .tag(2)
                .tabItem {
                    Text("Camera")
                    Image(systemName: "camera")
                        .padding()
            }
            SettingsView().environmentObject(subscriptionList)
                .tag(3)
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gear")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SubscriptionList())
    }
}
