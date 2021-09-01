//
//  SubListInfoRowView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 4/16/21.
//

import SwiftUI

struct SubListInfoRowView: View {
    @Binding var subscription:Subscription
    
    var body: some View {
        HStack {
           VStack(alignment: .leading) {
               Text(subscription.name)
               Text("Date Purchased: \(subscription.dateString)").font(.subheadline).foregroundColor(.gray)
           }
           Spacer()
           Text(String(format: "Cost: $ %.2f", subscription.cost))
       }
    }
}

//struct SubListInfoRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubListInfoRowView(subscription: <#T##Subscription#>)
//    }
//}
