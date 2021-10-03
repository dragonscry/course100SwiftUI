//
//  User.swift
//  User_and_friends
//
//  Created by Denys on 03.10.2021.
//

import Foundation

struct User : Codable {
    let id : String
    let isActive: Bool
    let name: String
    let age: Int
    let company : String
    let email : String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

struct Friend : Codable {
    let id: String
    let name: String
}
