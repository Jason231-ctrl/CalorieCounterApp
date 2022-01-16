//
//  Logs+CoreDataProperties.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//
//

import Foundation
import CoreData


extension Logs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Logs> {
        return NSFetchRequest<Logs>(entityName: "Logs")
    }

    @NSManaged public var hour: Int32
    @NSManaged public var name: String?
    @NSManaged public var calories: Double

}

extension Logs : Identifiable {

}
