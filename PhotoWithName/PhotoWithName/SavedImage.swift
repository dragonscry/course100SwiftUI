//
//  SavedImage.swift
//  PhotoWithName
//
//  Created by Denys on 31.10.2021.
//

import Foundation

struct SavedImage: Codable, Identifiable {
    var id: UUID
    var imageName : String
    var locations: [CodableMKPointAnnotation]
}

