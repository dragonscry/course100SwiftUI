//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Denys on 11.10.2021.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (()->Void)?
    var errorHandler: ((Error)->Void)?
    
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
        
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
