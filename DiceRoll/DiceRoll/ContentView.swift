//
//  ContentView.swift
//  DiceRoll
//
//  Created by Denys on 08.12.2021.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    @State private var isShowingSettings = false
    
    @State var numberOfDice = 1
    @State var numberofEdge = 6
    
    var body: some View {
        NavigationView {
            TabView {
                RollView(numberOfEdges: $numberofEdge, diceCount: $numberOfDice)
                    .tabItem {
                        VStack {
                            Text("Roll dice")
                            Image(systemName: "dice")
                        }
                    }
                ResultsView()
                    .tabItem{
                        VStack {
                            Text("Results")
                            Image(systemName: "info.circle")
                        }
                    }
            }
            .tabViewStyle(DefaultTabViewStyle())
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings = true
            }){
                Text("Settings")
            })
            .sheet(isPresented: $isShowingSettings){
                SettingsView(diceCount: $numberOfDice, edgeCount: $numberofEdge)
            }
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
