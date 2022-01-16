//
//  LogsModel.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import Foundation
import CoreData
public class LogsModel{
    let managedObjectContext:NSManagedObjectContext?
    init(context: NSManagedObjectContext){
        managedObjectContext = context
    }
    func getFirstLog() -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Logs", in: managedObjectContext!)
        let request: NSFetchRequest<Logs> = Logs.fetchRequest() as! NSFetchRequest<Logs>
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
    
    func getResults(i: Int) -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Logs", in: managedObjectContext!)
        let request: NSFetchRequest<Logs> = Logs.fetchRequest() as! NSFetchRequest<Logs>
        request.entity = entityDescription
        do{
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                match = results[i] as! NSManagedObject
            } else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return match
    }
    
    func getSize() -> Int? {
        var match:NSManagedObject?
        var number:Int = 0
        let entityDescription = NSEntityDescription.entity(forEntityName: "Logs", in: managedObjectContext!)
        let request: NSFetchRequest<Logs> = Logs.fetchRequest() as! NSFetchRequest<Logs>
        request.entity = entityDescription
        do{
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            number = results.count
            if results.count > 0 {
                match = results[0] as! NSManagedObject
            } else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return number
        
    }
    
    func cleardata(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Logs")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
        } catch let _ as NSError {
            
        }
    }
    func addLog(name:String, date:String, hour:Int32, calorie:Double){
        let entity = NSEntityDescription.entity(forEntityName: "Logs", in: self.managedObjectContext!)
        let added = Logs(entity: entity!, insertInto: managedObjectContext)
        added.name = name
        added.date = date
        added.hour = hour
        added.calories = calorie
        
        do{
            try managedObjectContext!.save()
            print("added food logs")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
