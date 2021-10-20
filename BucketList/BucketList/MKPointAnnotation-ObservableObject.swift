//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Denys on 20.10.2021.
//

import MapKit

extension MKPointAnnotation : ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown Subtitle"
        }
        set {
            subtitle = newValue
        }
    }
}
