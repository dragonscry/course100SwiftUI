//
//  ContentView.swift
//  User_and_friends
//
//  Created by Denys on 03.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var users = [User]()
    
    var body: some View {
        List(users, id: \.self){ user in
            VStack(alignment: .leading){
                Text(user.name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
