//
//  Result+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Denys on 09.12.2021.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var totalResult: Int16
    @NSManaged public var numberOfDice: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var dice: NSSet?
    
    var wrappedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd, yyyy"
        
        if let wrpDate = date {
            return formatter.string(from: wrpDate)
        } else {
            return formatter.string(from: Date())
        }
    }
    
    var wrappedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        if let wrpDate = date {
            return formatter.string(from: wrpDate)
        } else {
            return formatter.string(from: Date())
        }
    }
    
    var wrappedTotalResult: Int {
        Int(totalResult)
    }
    
    var wrappedNumberOfDice : Int {
        Int(numberOfDice)
    }
    
    var wrappedId : UUID {
        id ?? UUID()
    }
    
    var diceArray : [Dice] {
        let set = dice as? Set<Dice> ?? []
        let array = set.sorted{(firstDice, secondDice) -> Bool in
            firstDice.wrappedDiceResult > secondDice.wrappedDiceResult
        }
        
        return array
    }

}

// MARK: Generated accessors for dice
extension Result {

    @objc(addDiceObject:)
    @NSManaged public func addToDice(_ value: Dice)

    @objc(removeDiceObject:)
    @NSManaged public func removeFromDice(_ value: Dice)

    @objc(addDice:)
    @NSManaged public func addToDice(_ values: NSSet)

    @objc(removeDice:)
    @NSManaged public func removeFromDice(_ values: NSSet)

}

extension Result : Identifiable {

}
