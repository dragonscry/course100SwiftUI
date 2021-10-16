//
//  ContentView.swift
//  BucketList
//
//  Created by Denys on 16.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        Text(String(getDocumentDirectory))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
