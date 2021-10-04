//
//  UserDetails.swift
//  User_and_friends
//
//  Created by Denys on 04.10.2021.
//

import SwiftUI

struct UserDetails: View {
    
    @ObservedObject var allUsersData = AllUsers()
    let user : User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text(user.name)
                .font(.title)
            HStack{
                Text("\(user.age)")
                Text(user.company)
            }
            Text("\(user.email)")
            Text(user.address)
            VStack(alignment: .leading, spacing: 4){
                Text("About:")
                Text(user.about)
                    .foregroundColor(.secondary)
            }
            HStack{
                Text("Tags:")
                ScrollView(.horizontal){
                    HStack(spacing: 5) {
                        ForEach(user.tags, id: \.self){
                            tag in
                            Text("\(tag)").padding(7).background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))).cornerRadius(10)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            VStack(alignment:.leading){
                Text("Friends:")
                ScrollView(.vertical){
                    VStack(alignment:.leading){
                        ForEach(user.friends, id: \.self){
                            friend in
                            NavigationLink(destination: UserDetails(allUsersData: allUsersData, user: findUser(friend: friend.id))) {
                                Text(friend.name)
                                    .padding()
                                    .background(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            
        }
        .padding(.leading)
    }
    
    func findUser(friend: String) -> User{
        if let user = allUsersData.users.first(where: {$0.id == friend}){
            return user
        }
        return User(id: "none", isActive: false, name: "Unknown User", age: 0, company: "None", email: "none", address: "none", about: "none", registered: "none", tags: ["none"], friends: [Friend(id: "none", name: "none")])
    }
}

struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails(user: User(id: "Test", isActive: true, name: "Todd Govarts", age: 22, company: "Ubisoft", email: "ppp@ubi.com", address: "Kyiv", about: "Something about me", registered: "There", tags: ["games","gym"],friends: [Friend(id: "trst", name: "Phill Spenser")]))
    }
}
