//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Denys on 19.09.2021.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(0..<Order.types.count, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any Special Requestes?")
                    }
                    
                    if order.specialRequestEnabled{
                        Toggle(isOn: $order.extraFrosting){
                            Text("Add Extra Frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles){
                            Text("Add Extra Sprinkles?")
                        }
                    }
                    Section{
                        NavigationLink(destination: AddressView(order: order)){
                            Text("Delivery Details")
                        }
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
