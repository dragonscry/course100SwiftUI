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
    
    var body: some View {
        NavigationView {
            TabView {
                RollView()
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
            .navigationTitle("Roll Dice")
            .navigationBarItems(trailing: Button(action: {
                isShowingSettings = true
            }){
                Text("Settings")
            })
            .sheet(isPresented: $isShowingSettings){
                SettingsView()
            }
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
