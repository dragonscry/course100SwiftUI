//
//  ManageData.swift
//  PhotoWithName
//
//  Created by Denys on 01.11.2021.
//

import SwiftUI

class ManageData {
    static func loadPictures(pathName: String) -> [SavedImage] {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try Data(contentsOf: filename)
            let pictures = try JSONDecoder().decode([SavedImage].self, from: data)
            return pictures
        } catch {
            print("Error: Unable to load saved data")
        }
        return []
    }
    
    static func savedPictures(pathName: String, savedImages: [SavedImage]) {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        
        do {
            let data = try JSONEncoder().encode(savedImages)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Error: Unable to save data")
        }
    }
    
    static func savesImage(pathName: String, inputImage: UIImage?){
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            }
        } catch {
            print("Error: Unable to save image")
        }
    }
    
    static func removeImage(pathName: String) {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            try FileManager.default.removeItem(at: filename)
        } catch {
            print("Error: Unable to delete picture")
        }
    }
    
    static func loadImage(pathName: String) -> Data? {
        let filename = getDocumentsDirectory().appendingPathComponent(pathName)
        do {
            let data = try Data(contentsOf: filename)
            return data
        } catch {
            print("Error: Unable to load image")
        }
        return nil
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
