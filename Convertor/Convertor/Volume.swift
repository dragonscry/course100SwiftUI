//
//  Volume.swift
//  Convertor
//
//  Created by Denys on 29.08.2021.
//

import SwiftUI

struct Volume: View {
    let values : [String:Double] = ["ml":1, "l":1000, "cup":237, "pint":473, "gl":3785]
    let array = ["ml","l","cup","pint","gl"]
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
                    Text("Volume Convertor:").font(.title)
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
            
        }.frame(width: 350, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))).cornerRadius(20)
    }
}

struct Volume_Previews: PreviewProvider {
    static var previews: some View {
        Volume()
    }
}
