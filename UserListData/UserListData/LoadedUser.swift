//
//  LoadedUser.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//

import Foundation
import SwiftUI

struct LoadedUser: Codable, Identifiable {
    var id: String?
    var name: String?
    var age: Int
    var company: String?
    var isActive: Bool
    var friends: [LoadedFriend]
    
}

struct LoadedFriend: Codable, Identifiable {
    var id: String?
    var name: String?
}
