//
//  ContentView.swift
//  Length Converter
//
//  Created by Dmitry Sharabin on 22.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var inputUnit = UnitLength.inches
    @State private var outputUnit = UnitLength.meters
    @FocusState private var inputIsFocused: Bool
    
    private let units: [UnitLength] = [.inches, .feet, .yards, .meters, .kilometers, .miles]
    
    var output: Double {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return outputMeasurement.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter a number", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Choose unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert")
                }
                
                Section {
                    Picker("Choose unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text(output.formatted())
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
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
