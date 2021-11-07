//
//  ContentView.swift
//  HotProspects
//
//  Created by Denys on 02.11.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello Swift")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu{
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                    }
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }
                    Button(action: {
                        self.backgroundColor = .yellow
                    }) {
                        Text("Yellow")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
