//
//  ContentView.swift
//  User_and_friends
//
//  Created by Denys on 03.10.2021.
//

import SwiftUI

 class AllUsers:ObservableObject {
    @Published var users = [User]()
}

struct ContentView: View {
    
    @ObservedObject var allUsersData = AllUsers()
    
    var body: some View {
        NavigationView {
            List(allUsersData.users, id: \.id){ user in
                NavigationLink(destination: UserDetails(allUsersData: allUsersData, user: user)) {
                    VStack(alignment: .leading){
                        Text(user.name)
                    }
                }
            }
            .onAppear(perform: {
                loadData()
        })
            .navigationBarTitle("Users")
        }
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
                        allUsersData.users = decodedResponse
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
