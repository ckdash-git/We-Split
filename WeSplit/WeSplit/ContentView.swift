//  ContentView.swift
//  WeSplit
//
//  Created by Chandan Kumar Dash on 09/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tipsPercentage = 20
    @State private var numberOfPerson = 0
    @State private var checkAmount = 0.0
    
    @FocusState private var amountIsFocoused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerson: Double {
        let peopleCount = Double(numberOfPerson + 2)
        let tipSelection = Double(tipsPercentage)
        
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EURO"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocoused)
                    
                    Picker("Number of people", selection: $numberOfPerson){
                        ForEach(1..<11) {
                            Text("\($0) people")
                        }
                        
                    }
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipsPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section{
                    Text(totalPerson, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocoused {
                        Button("Done") {
                            amountIsFocoused = false
                        }
                    }
                }
                
            }
            
        }
        
    }
    
}


#Preview {
    ContentView()
}
