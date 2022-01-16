//
//  PersonModel.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//

import Foundation
import CoreData

public class PersonModel{
    let managedObjectContext:NSManagedObjectContext?
    init(context: NSManagedObjectContext){
        managedObjectContext = context
    }
    func getPerson(diet: String) -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: managedObjectContext!)
        let request: NSFetchRequest<Person> = Person.fetchRequest() as! NSFetchRequest<Person>
        request.entity = entityDescription
        let pred = NSPredicate(format: "(diet = %@)", diet)
        request.predicate = pred
        //request.fetchLimit = 1
        do{
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                match = results[0] as! NSManagedObject
            } else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return match
    }
    
    func getPersonFirst() -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Person", in: managedObjectContext!)
        let request: NSFetchRequest<Person> = Person.fetchRequest() as! NSFetchRequest<Person>
        request.entity = entityDescription
        do{
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                match = results[0] as! NSManagedObject
            } else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return match
    }
    
    func cleardata(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
        } catch let _ as NSError {
            
        }
    }
    func setPerson(age: Double, diet: String, height: Double, iweight: Double, weight: Double){
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: self.managedObjectContext!)
        let added = Person(entity: entity!, insertInto: managedObjectContext)
        added.age = age
        added.diet = diet
        added.height = height
        added.iweight = iweight
        added.weight = weight
        
        do{
            try managedObjectContext!.save()
            print(added.diet)
            print("Person Info Saved")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
