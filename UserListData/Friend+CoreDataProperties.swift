//
//  Friend+CoreDataProperties.swift
//  UserListData
//
//  Created by Denys on 04.10.2021.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: User?
    
    public var wrappedId : String {
        id ?? "Unknown Id"
    }
    public var wrappedName : String {
        name ?? "Unknown Name"
    } 

}

extension Friend : Identifiable {

}
