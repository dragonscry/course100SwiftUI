//
//  User.swift
//  User_and_friends
//
//  Created by Denys on 03.10.2021.
//

import Foundation

struct User : Codable, Hashable {
    var id : String
    var isActive: Bool
    var name: String
    var age: Int
    var company : String
    var email : String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend : Codable, Hashable {
    var id: String
    var name: String
}
