//
//  ContentView.swift
//  Length Converter
//
//  Created by Dmitry Sharabin on 22.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var selectedInputUnit = "in"
    @State private var selectedOutputUnit = "m"
    @FocusState private var inputIsFocused: Bool
    
    private let units = ["in", "ft", "yd", "m", "km", "mi"]
    
    var output: Double {
        let inputUnit: UnitLength
        let outputUnit: UnitLength
        
        switch selectedInputUnit {
            case "in":
                inputUnit = .inches
            case "ft":
                inputUnit = .feet
            case "yd":
                inputUnit = .yards
            case "m":
                inputUnit = .meters
            case "km":
                inputUnit = .kilometers
            case "mi":
                inputUnit = .miles
            default:
                inputUnit = .inches
        }
        
        switch selectedOutputUnit {
            case "in":
                outputUnit = .inches
            case "ft":
                outputUnit = .feet
            case "yd":
                outputUnit = .yards
            case "m":
                outputUnit = .meters
            case "km":
                outputUnit = .kilometers
            case "mi":
                outputUnit = .miles
            default:
                outputUnit = .meters
        }
        
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
                    
                    Picker("Choose unit", selection: $selectedInputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert")
                }
                
                Section {
                    Picker("Choose unit", selection: $selectedOutputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Into")
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
