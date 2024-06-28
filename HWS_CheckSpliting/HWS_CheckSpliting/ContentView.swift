//
//  ContentView.swift
//  HWS_CheckSpliting
//
//  Created by Maria Vounatsou on 11/4/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = 0..<101
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var originalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("squaers")
                    .opacity(0.8)
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 700, alignment: .bottom)
                
                VStack {
                    Form {
                        Section {
                            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                                .cornerRadius(7)
                            
                            Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2..<100) {
                                    Text("\($0) people")
                                }
                            }
                            
                            .bold()
                        }
                        
                        Section {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("How much do you want to tip?")
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                            // .stroke(Color.red, lineWidth: 2)
                                                .fill(Color.white)
                                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                            
                                        )
                                        .fontWeight(.heavy)
                                        .foregroundStyle(Color.red)
                                }
                                
                                Picker("Tip percentage", selection: $tipPercentage) {
                                    ForEach(tipPercentages, id: \.self) {
                                        Text($0, format: .percent)
                                    }
                                }
                                .bold()
                                .cornerRadius(7)
                                .pickerStyle(.navigationLink)
                            }
                        }
                        
                        Section {
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .bold()
                                .cornerRadius(7)
                        } header: {
                            HStack {
                                Text("Amount per person")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white)
                                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                    )
                                    .fontWeight(.heavy)
                                    .foregroundStyle(Color.red)
                            }
                        }
                        
                        Section(header: HStack {
                            Text("Original Amount")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white)
                                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                                )
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.red)
                                .font(.system(size: 16))
                        }) {
                            Text(originalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .frame(width: 300, height: 10)
                                .padding()
                                .background(tipPercentage == 0 ? .red : .green)
                        }
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Text("WeSplit")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(.red)
                            }
                        }
                        
                        .toolbar {
                            if amountIsFocused {
                                Button("Done") {
                                    amountIsFocused = false
                                }
                            }
                        }
                    }
                }
                .background(Color.clear)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

