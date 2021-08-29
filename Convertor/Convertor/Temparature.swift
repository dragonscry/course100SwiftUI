//
//  Temparature.swift
//  Convertor
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct Temparature: View {
    
    let values = ["Celsium", "Fahrenheit", "Kelvin"]
    @State private var value1 = 0
    @State private var value2 = 0
    @State private var amount = ""
    
    func convention (val1 : Int, val2: Int) -> Double {
        
        var temp : Double = 0
        let totalAmount = Double(amount) ?? 0
        switch values[val1]{
        case "Fahrenheit":
            temp = (totalAmount - 32) * (5/9)
        case "Kelvin":
            temp = totalAmount - 273
        default:
            temp = totalAmount
        }
        
        switch values[val2]{
        case "Fahrenheit":
            temp = temp * (9/5) + 32
        case "Kelvin":
            temp = temp + 273
        default:
            temp = temp + 0
        }
        
        return temp
    }
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Temparature Convertor").font(.title)
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    HStack {
                        Text("From:")
                        Picker("From:", selection: $value1){
                            ForEach(0 ..< values.count) {
                                Text(values[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack{
                        Text("To:     ")
                        Picker("To:", selection: $value2){
                            ForEach(0 ..< values.count) {
                                Text(values[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Text("In \(amount) \(values[value1]) is \(convention(val1: value1, val2: value2),specifier: "%.2f") \(values[value2])")
                        .padding(.top)
                    Spacer()
                }
            }
            .padding([.top, .leading, .trailing])
            Spacer()
            
        }.frame(width: 350, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))).cornerRadius(20)
    }
}

struct Temparature_Previews: PreviewProvider {
    static var previews: some View {
        Temparature()
    }
}
