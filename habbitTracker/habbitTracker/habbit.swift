//
//  habbit.swift
//  habbitTracker
//
//  Created by Denys on 18.09.2021.
//

import Foundation

struct Habbit : Identifiable, Codable{
    var id = UUID()
    let name : String
    let description : String
    var count : Int
}

class Habbits : ObservableObject {
    @Published var habbits = [Habbit](){
        didSet{
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(habbits){
                UserDefaults.standard.set(encoded, forKey: "Habbits")
            }
        }
    }
    
    init(){
        if let habbits = UserDefaults.standard.data(forKey: "Habbits"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habbit].self, from: habbits) {
                self.habbits = decoded
                return
            }
        }
        self.habbits = []
    }
}
