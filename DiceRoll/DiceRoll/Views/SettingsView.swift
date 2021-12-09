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
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
        VStack{
            Text("How many dice you want to roll")
                .padding(.top, 20)
            Picker("CountDice", selection: $diceCount) {
                ForEach(numberOfDice, id: \.self) { dice in
                    Text("\(dice)")
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            .colorMultiply(.green)
            
            Text("How many edges in your dice")
                .padding(.top, 20)
            Picker("Edges", selection: $edgeCount) {
                ForEach(edgeCounts, id: \.self) { dice in
                    Text("\(dice)")
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            .colorMultiply(.purple)
            
            Button(action: {
                presentation.wrappedValue.dismiss()
            }){
                Text("Done")
            }
            
            Spacer()
            
        }
        .navigationTitle("Settings")
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
