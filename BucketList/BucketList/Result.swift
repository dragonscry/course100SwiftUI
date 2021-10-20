//
//  Result.swift
//  BucketList
//
//  Created by Denys on 20.10.2021.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid : Int
    let title : String
    let terms: [String: [String]]?

}
