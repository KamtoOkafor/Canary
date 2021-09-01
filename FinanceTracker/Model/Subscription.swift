//
//  Subscription.swift
//  FinanceTracker
//
//  Created by Keegan West on 3/18/21.
//

import Foundation

class Subscription: ObservableObject, Identifiable {
    @Published var name: String = ""
    @Published var cost: String = ""
    @Published var isYearly: Bool
    @Published var datePurchased: Date
    @Published var formatter = DateFormatter()
    @Published var dateString: String = ""
    @Published var image: Data? = nil
    @Published var id: UUID = UUID()
    
    
    init(name: String, cost: String, isYearly: Bool, datePurchased: Date) {
        self.name = name
        self.cost = cost
        self.isYearly = isYearly
        self.datePurchased = datePurchased
        self.formatter.dateFormat = "MM/dd/YY"
        self.dateString = formatter.string(from: datePurchased)
        self.id = UUID()
        
    }
    
   func setDate(datePurchased: Date)
    {
        print(datePurchased)
        self.datePurchased = datePurchased
        self.formatter.dateFormat = "MM/dd/YY"
        self.dateString = formatter.string(from: self.datePurchased)
        print(dateString)
    }
    
    init() {
        self.name = ""
        self.cost = "0.0" //will need to be converted to float later
        self.isYearly = false
        self.datePurchased = Date()
        self.formatter.dateFormat = "MM/dd/YY"
        self.dateString = formatter.string(from: self.datePurchased)
        self.id = UUID()
    }
}
