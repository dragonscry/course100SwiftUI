//
//  Prospect.swift
//  HotProspects
//
//  Created by Denys on 10.11.2021.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people : [Prospect]
    
    init() {
        self.people = []
    }
}
