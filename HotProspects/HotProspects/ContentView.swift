//
//  ContentView.swift
//  HotProspects
//
//  Created by Denys on 02.11.2021.
//

import SwiftUI
import SamplePackage

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
