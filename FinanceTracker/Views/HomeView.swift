//
//  HomeView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 3/17/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var subscriptionList: SubscriptionList

    var body: some View {
        VStack {
            ZStack {
                HeaderView(title: "Current Subscriptions", subtitle: "", bgColor: Color("customBlue"))
                VStack{
                    ZStack {
                        Rectangle().foregroundColor(Color.white)
                            .frame(height: 40)
                        Text(String(format: "TOTAL COST: $ %.2f", subscriptionList.overallCost)).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                    }
                }.offset(y:-258)
                
                VStack {
                    Spacer().frame(height: 100, alignment: .center)
                    Spacer().frame( height: 40, alignment: .center)
                    List {
                        Section(header: MonthlyHeader(monthCost: $subscriptionList.totalMonthlyCost)) {
                            ForEach(subscriptionList.monthlyList, id: \.id) { sub in
                                
                                HStack {
                                   VStack(alignment: .leading) {
                                       Text(sub.name)
                                       Text("Date Purchased: \(sub.dateString)").font(.subheadline).foregroundColor(.gray)
                                   }
                                   Spacer()
                                   Text("Cost: \(sub.cost)")
                               }
                                
                            }.onAppear(){
//                                if (subscriptionList.$monthlyList.count() != 0) {
//                                    print(subscriptionList.$monthlyList[0].cost)
//                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())

                    List {
                        Section(header: YearlyHeader(yearCost: $subscriptionList.totalYearlyCost)) {
                            ForEach(subscriptionList.yearlyList, id: \.id) { sub in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(sub.name)
                                        Text("Date Purchased: \(sub.dateString)").font(.subheadline).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("Cost: \(sub.cost)")
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }
                Spacer()
            }
        }
    }
}

struct MonthlyHeader: View {
    @Binding var monthCost: Double
    var body: some View {
        HStack {
            Image(systemName: "creditcard.circle").resizable().frame(width: 20, height: 20, alignment: .center)
            Text("Total Monthly Cost: $ \(monthCost)")
        }
    }
}

struct YearlyHeader: View {
    @Binding var yearCost: Double
    var body: some View {
        HStack {
            Image(systemName: "creditcard.circle").resizable().frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("Total Yearly Cost: $ \(yearCost)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(SubscriptionList())
    }
}
