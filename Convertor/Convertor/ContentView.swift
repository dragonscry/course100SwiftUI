//
//  ContentView.swift
//  Convertor
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var value = 0
    let converteredValues = ["Temparature", "Length", "Time","Volume"]
    
    var body: some View {
        VStack{
            Picker("What",selection:$value){
                ForEach(0 ..< converteredValues.count){
                    Text(converteredValues[$0])
                }
            }.pickerStyle(SegmentedPickerStyle()).padding()
            
            switch converteredValues[value]{
            case "Temparature":
                Temparature()
            case "Length":
                Length()
            case "Time":
                Time()
            case "Volume":
                Volume()
            default:
                Temparature()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
