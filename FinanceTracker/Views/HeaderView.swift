//
//  HeaderView.swift
//  FinanceTracker
//
//  Created by Killah-Kam on 4/16/21.
//

import SwiftUI

struct HeaderView: View {
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var bgColor: Color
    
    var body: some View {
       GeometryReader { geometry in
               ZStack {
                   Ellipse()
                   .fill(self.bgColor)
                   .frame(width: geometry.size.width * 1.4, height: geometry.size.height * 0.288)
                   .position(x: geometry.size.width / 2.35, y: geometry.size.height * 0.03)
                   .shadow(radius: 2)
                   .edgesIgnoringSafeArea(.all)
                
                
                
                HStack {
                     VStack(alignment: .leading) {
                         Text(self.title)
                             .font(.title)
                             .fontWeight(.bold)
                             .foregroundColor(Color.white)
                         
                         Text(self.subtitle)
                             .font(.subheadline)
                             .fontWeight(.regular)
                             .foregroundColor(Color.white)
                         Spacer()
                     }
                     .padding(.leading, 25)
                     .padding(.top, 10)
//                     .padding(.bottom, 200)
                    Spacer()
                    
                }
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Subscriptions", subtitle: "", bgColor: Color("customBlue"))
    }
}
