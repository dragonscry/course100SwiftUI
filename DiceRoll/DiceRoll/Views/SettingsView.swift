//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var diceCount : Int
    let numberOfDice = [1,2,3]
    @Binding var edgeCount : Int
    let edgeCounts = [4,6,8,10,12,20,100]
    
   // @Binding var edge : Int
    
    var body: some View {
        
        VStack{
            Text("How many dice you want to roll")
            Picker("CountDice", selection: $diceCount) {
                ForEach(numberOfDice, id: \.self) { dice in
                    Text("\(dice)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Text("How many edges in your dice")
            Picker("Edges", selection: $edgeCount) {
                ForEach(edgeCounts, id: \.self) { dice in
                    Text("\(dice)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
