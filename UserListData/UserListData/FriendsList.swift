//
//  FriendsList.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//

import SwiftUI

struct FriendsListView: View {
    var friends: [Friend]
    
    
    var body: some View {
        VStack {
            Text("Friends:")
            List() {
                ForEach(friends, id: \.wrappedId){ friend in
                    NavigationLink(destination: DetailUserView(userId: friend.wrappedId)){
                        VStack(alignment: .leading){
                            Text(friend.wrappedName)
                        }
                    }
                }
            }
        }
    }
}
