//
//  Food+CoreDataProperties.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//
//

import Foundation
import CoreData


extension Food {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Food> {
        return NSFetchRequest<Food>(entityName: "Food")
    }

    @NSManaged public var calorie: Double
    @NSManaged public var carb: Double
    @NSManaged public var detail: String?
    @NSManaged public var fat: Double
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var protein: Double
    @NSManaged public var sugar: Double

}

extension Food : Identifiable {

}
