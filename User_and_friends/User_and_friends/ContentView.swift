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
        List(users, id: \.id){ user in
            VStack(alignment: .leading){
                Text(user.name)
            }
        }
        .onAppear(perform: {
            loadData()
        })
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid Url")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data){
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    
                    return
                }
            }
            print ("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
            
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
