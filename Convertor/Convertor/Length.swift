//
//  Length.swift
//  Convertor
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct Length: View {
    let values = ["m":1,"km":1000, "ft":0.3, "yd":1.094, "mile":1609]
    let array = ["m","km","ft","yd","miles"]
    @State private var value1 = 0
    @State private var value2 = 0
    @State private var amount = ""
    
    func convention (val1 : Int, val2: Int) -> Double {
        let totalAmount = Double(amount) ?? 0
        
        let k1 = values[array[val1]] ?? 1
        let k2 = values[array[val2]] ?? 1
        return totalAmount * k1 / k2
    }
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Length Convertor").font(.title)
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    HStack {
                        Text("From:")
                        Picker("From:", selection: $value1){
                            ForEach(0 ..< array.count) {
                                Text(array[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack{
                        Text("To:     ")
                        Picker("To:", selection: $value2){
                            ForEach(0 ..< array.count) {
                                Text(array[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    
                    Text("In \(amount) \(array[value1]) is \(convention(val1: value1, val2: value2),specifier: "%.2f") \(array[value2])")
                        .padding(.top)
                    Spacer()
                }
            }
            .padding([.top, .leading, .trailing])
            Spacer()
            
        }.frame(width: 350, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1))).cornerRadius(20)
    }
}

struct Length_Previews: PreviewProvider {
    static var previews: some View {
        Length()
    }
}
