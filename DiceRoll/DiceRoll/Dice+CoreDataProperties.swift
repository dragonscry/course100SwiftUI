//
//  Dice+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Denys on 09.12.2021.
//
//

import Foundation
import CoreData


extension Dice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dice> {
        return NSFetchRequest<Dice>(entityName: "Dice")
    }

    @NSManaged public var numberOfSides: Int16
    @NSManaged public var diceResult: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var mainResult: Result?
    
    var wrappedNumberOfSides: Int {
        Int(numberOfSides)
    }
    
    var wrappedDiceResult: Int {
        Int(diceResult)
    }
    
    var wrappedId: UUID {
        id ?? UUID()
    }
    

}

extension Dice : Identifiable {

}
