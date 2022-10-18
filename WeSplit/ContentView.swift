//
//  ContentView.swift
//  WeSplit
//
//  Created by DJ on 9/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    let tipPercentages = [10, 15, 20, 25, 0]
    var grandTotal: Double {
        let tipValue = checkAmount / 100 * Double(tipPercentage)
        return (checkAmount + tipValue)
    }
    var perPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return grandTotal / peopleCount
            }
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("How much is the bill?")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip?")
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total amount with tip is:")
                }
                Section {
                    Text(perPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                } header: {
                    Text("Per person amount")
                }
        }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
   }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
