//
//  ContentView.swift
//  WeSplit
//
//  Created by Victor Melo on 15/10/19.
//  Copyright © 2019 Victor Melo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 0
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        return f
    }()

    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = (orderAmount/100) * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalAmountFormatted: String {
        return currencyFormatter.string(from: NSNumber(value: totalAmount)) ?? ""
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double((Int(numberOfPeople) ?? 0) + 2)
        
        return totalAmount / peopleCount
    }
    
    var totalPerPersonFormatted: String {
        return currencyFormatter.string(from: NSNumber(value: totalPerPerson)) ?? ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("number_of_people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("how_much_tip_do_you_want_to_leave")) {
                    Picker("tip_percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("total_amount")) {
                    Text(totalAmountFormatted)
                }
                
                Section(header: Text("amount_per_person")) {
                    Text(totalPerPersonFormatted)
                }
            }
            .navigationBarTitle("we_split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.locale, Locale(identifier: "en"))
            ContentView()
                .environment(\.locale, Locale(identifier: "pt_br"))
        }
    }
}
