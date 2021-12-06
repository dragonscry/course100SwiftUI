//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Denys on 01.12.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
