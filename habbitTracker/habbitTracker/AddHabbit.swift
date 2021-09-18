//
//  AddHabbit.swift
//  habbitTracker
//
//  Created by Denys on 18.09.2021.
//

import SwiftUI

struct AddHabbit: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habbits : Habbits
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name your habit", text: $name)
                
                TextField("Type Desctiption", text: $description)
            }
            .navigationBarTitle("Add Habit")
            .navigationBarItems(trailing: Button("Save"){
                let habbit = Habbit(name: self.name, description: self.description, count: 0)
                    self.habbits.habbits.append(habbit)
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddHabbit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabbit(habbits: Habbits())
    }
}
