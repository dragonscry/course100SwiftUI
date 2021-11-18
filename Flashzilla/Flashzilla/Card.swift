//
//  Card.swift
//  Flashzilla
//
//  Created by Denys on 18.11.2021.
//

import Foundation

struct Card {
    let prompt: String
    var answer: String
    
    static var example: Card {
        Card(prompt: "Who played 13th doctor in Doctor Who? ", answer: "Joddie Whittaker")
    }
}
