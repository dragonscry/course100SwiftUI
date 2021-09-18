//
//  ContentView.swift
//  habbitTracker
//
//  Created by Denys on 18.09.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habbits = Habbits()
    @State private var addHabbit = false
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(habbits.habbits){
                    habbit in
                    HStack{
                        VStack(alignment: .leading){
                            Text(habbit.name).font(.headline)
                            Text(habbit.description)
                        }
                        Spacer()
                        Text("Time Done :\(habbit.count)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("My Habits")
            .navigationBarItems(leading: EditButton(), trailing:
                                    Button(action: {
                                        self.addHabbit = true
                                    }){
                                        Image(systemName: "plus")
                                    }
                                
            )
            .sheet(isPresented: $addHabbit, content: {
                AddHabbit(habbits: self.habbits)
            })
            
        }
    }
    func removeItems(at offset: IndexSet){
        habbits.habbits.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
