//
//  SubscriptionView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 3/17/21.
//

import SwiftUI

extension String {
    func isEqualToString(find: String) -> Bool {
         String(format: self) == find
    }
}

struct SubscriptionView: View {
    @EnvironmentObject var subscriptionList : SubscriptionList
    @State var subscription : Subscription = Subscription()
    @State var name: String = ""
    @State var cost: String = ""
    @State var isYearly: Bool = false
    @State private var selectedIndex = 0
    
    @State var showBanner:Bool = false
    @State var  bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "", detail: "", type: .Info)
    @State var selectedDate = Date()
    

    var body: some View {

            VStack {
                ZStack {
                    HeaderView(title: "Add Subscriptions", subtitle: "", bgColor: Color("customBlue")).offset(y:1)
                
                    VStack {
                        Spacer().offset(y:60)
                        Form {
                            Section(header: Text("Subscription Information")) {
                                TextField("Subscription Name", text: $name)
                                        .frame(width: 300, height: 50, alignment: .center)
                                
                                TextField("Cost", text: $cost)
                                    .frame(width: 300, height: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                
                                DatePicker(selection: $selectedDate, in: ...Date(), displayedComponents: .date) {
                                    Text("Date Purchased:")
                                }
                                
                            }
                            
                            Section(header: Text("Subscription Type")) {
                                Picker("Subscription Type:", selection: $selectedIndex) {
                                    Text("Monthly").tag(0)
                                    Text("Yearly").tag(1)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            
                            Button(action: {
                                subscription = Subscription(name: name, cost: cost, isYearly: isYearly, datePurchased: selectedDate)
                                subscription.setDate(datePurchased: selectedDate)
                                print("cost: \(cost)")
                                print("subscription added")

                                if (selectedIndex == 0)
                                {
                                    isYearly = false;
                                }
                                else
                                {
                                    isYearly = true;
                                }
                                
                                subscriptionList.addSub(subscription, isYearly)
                                print("added sub cost: \(subscription.cost)")
                                if (isYearly) {
                                    bannerData = BannerModifier.BannerData(title: "Subscription Added!",
                                            detail: "Your yearly subscription of \(subscription.name) has been added ", type: .Success)
                                    showBanner = true
                                    
                                } else {
                                    bannerData = BannerModifier.BannerData(title: "Subscription Added!",
                                            detail: "Your monthly subscription of \(subscription.name) has been added ", type: .Info)
                                    showBanner = true
                                }
                                
                                name = ""
                                cost = "0.0"
                                isYearly = false
                                selectedDate = Date()

                            })
                            {
                                HStack {
                                        Spacer()
                                        Text("Add")
                                        Spacer()
                                    }

                            }.disabled(name.isEmpty).banner(data: $bannerData, show: $showBanner).padding()
                            // end of form
                        }.offset(y:40)
                        // end of second zstack
                    }.offset(y:32)
                  // end of fist zstack
                }
                // end of first vstack
            }
    
    }
}



struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView().environmentObject(SubscriptionList())
    }
}
