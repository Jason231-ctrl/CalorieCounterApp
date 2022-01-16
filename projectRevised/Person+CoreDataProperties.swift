//
//  Person+CoreDataProperties.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Double
    @NSManaged public var diet: String?
    @NSManaged public var height: Double
    @NSManaged public var iweight: Double
    @NSManaged public var weight: Double

}

extension Person : Identifiable {

}
