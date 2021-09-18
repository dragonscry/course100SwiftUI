//
//  HabbitView.swift
//  habbitTracker
//
//  Created by Denys on 18.09.2021.
//

import SwiftUI

struct HabbitView: View {
    
    let name : String
    let description : String
    @State var count : Int
    
    var body: some View {
        VStack{
            VStack(alignment: .leading) {
                Text("Habbit : \(name)")
                    .font(.largeTitle)
                Text("Description: \(description)")
                    .font(.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("How many times you do it : \(count)")
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
        .frame(width: .infinity)
    }
    
    func increment(){
        self.count += 1
    }
}

struct HabbitView_Previews: PreviewProvider {
    static var previews: some View {
        HabbitView(name: "test", description: "test Description", count: 2)
    }
}
