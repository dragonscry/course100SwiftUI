//
//  HabbitView.swift
//  habbitTracker
//
//  Created by Denys on 18.09.2021.
//

import SwiftUI

struct HabbitView: View {
    @State var habbit : Habbit
    @ObservedObject var habbits : Habbits
    
    var body: some View {
        VStack{
            VStack{
                Text("Habbit : \(habbit.name)")
                    .font(.largeTitle)
                Text("Description: \(habbit.description)")
                    .font(.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("How many times you do it : \(habbit.count)")
            }
            
            
            Spacer()
            
            Button(action: {increment()}, label: {
                Text("I done it againt")
            })
            .padding()
            .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
            .foregroundColor(.white)
            .cornerRadius(15)
        }
        
    }
    
    func increment(){
        if let index = self.habbits.habbits.firstIndex(where: {$0.id == self.habbit.id}){
            habbits.habbits[index].count += 1
            self.habbit.count += 1
        }
    }
}

struct HabbitView_Previews: PreviewProvider {
    static var previews: some View {
        HabbitView(habbit: Habbit(name: "Test", description: "Test Descr", count: 2), habbits: Habbits())
    }
}
