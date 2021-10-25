//
//  ContentView.swift
//  BucketList
//
//  Created by Denys on 16.10.2021.
//
import LocalAuthentication
import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        if isUnlocked {
            MainContent()
        } else {
            UnlockedButton(isUnlocked: $isUnlocked)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
