//
//  UserView.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//

import SwiftUI

struct UserView: View {
    
    @State private var isShowFriendList = false
    var user: User
    
    var body: some View {
        Form {
            Section(header: Text("Name")){
                Text(user.wrappedName)
            }
            Section(header: Text("Age")){
                Text("\(user.wrappedAge)")
            }
            Section(header: Text("Company")){
                Text("\(user.wrappedCompany)")
            }
            
            Section(header: Text("Is Activity")){
                Text(user.checkIsActive)
            }
            
            Section(header: Text("Switch to show friends")){
                Toggle(isOn: $isShowFriendList){
                    Text("Show \(user.wrappedName)'s friends")
                }
            }
            
            if isShowFriendList{
                Section(header: Text("\(user.wrappedName)'s Friends:")){
                    NavigationLink(destination: FriendsListView(friends: self.user.friendsArray)){
                        Text("Show \(user.wrappedName)'s friends")
                    }
                    
                }
            }
        }
    }
}
//
//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
