//
//  TestingView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 4/16/21.
//

import SwiftUI

struct TestingView: View {
        @EnvironmentObject var subscriptionList : SubscriptionList

        @State var username: String = ""
        @State var isPrivate: Bool = true
        @State private var previewIndex = 0
    
        @State private var notificationIsOn = false
        @State private var askedForHelp = false
    
        var previewOptions = ["Always", "When Unlocked", "Never"]

        var body: some View {
            VStack {
                NavigationView {
                    Form {
                        Section(header: Text("PROFILE")) {
                            TextField("Username", text: $username)
                            Toggle(isOn: $isPrivate) {
                                Text("Display Username")
                            }
                        }

                        Section(header: Text("NOTIFICATIONS")) {
                            Toggle(isOn: $notificationIsOn) {
                                Text("Enabled")
                            }

                            Picker(selection: $previewIndex, label: Text("Show Previews")) {
                                ForEach(0 ..< previewOptions.count) {
                                    Text(self.previewOptions[$0])
                                }
                            }
                        }

                        Section(header: Text("ABOUT")) {
                            HStack {
                                Text("Version")
                                Spacer()
                                Text("2.2.1")
                            }
                        }

                        Section {
                            Button("Found a bug?") {
                                askedForHelp = true
                            }.alert(isPresented: $askedForHelp) {
                                Alert(
                                        title: Text("Email the Developer"),
                                        message: Text("Email: testing@gmail.com")
                                )
                            }
                        }
                    }
                    .navigationBarTitle("Settings")
                }
            }.onChange(of: notificationIsOn) { notificationIsOn in
                if notificationIsOn {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            //print("all set")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    subscriptionList.turnNotificationsOnOrOff(turnOn: true)
                } else {
                    subscriptionList.turnNotificationsOnOrOff(turnOn: false)
                }
            }
        }
}



struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView().environmentObject(SubscriptionList())
    }
}
