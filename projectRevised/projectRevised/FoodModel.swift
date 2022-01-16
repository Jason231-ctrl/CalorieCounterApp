//
//  FoodModel.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//

import Foundation
import CoreData
import UIKit

public class FoodModel {
    let managedObjectContext:NSManagedObjectContext?
    init(context:NSManagedObjectContext){
        managedObjectContext = context
    }
    
    func findFood(name: String) -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Food", in: managedObjectContext!)
        let request: NSFetchRequest<Food> = Food.fetchRequest() as! NSFetchRequest<Food>
        request.entity = entityDescription
        let pred = NSPredicate(format: "(name = %@)", name)
        request.predicate = pred
        do {
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                match = results[0] as! NSManagedObject
            }
            else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
        return match
    }
    
    
    func getResults(i: Int) -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Food", in: managedObjectContext!)
        let request: NSFetchRequest<Food> = Logs.fetchRequest() as! NSFetchRequest<Food>
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
    
    func updateImage(name: String, image: Data){
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Food", in: managedObjectContext!)
        let request: NSFetchRequest<Food> = Food.fetchRequest() as! NSFetchRequest<Food>
        request.entity = entityDescription
        let pred = NSPredicate(format: "(name = %@)", name)
        request.predicate = pred
        do {
            var results = try managedObjectContext!.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
            if results.count > 0 {
                match = results[0] as! NSManagedObject
                match?.setValue(image, forKey: "image")
                try managedObjectContext!.save()
                print("Image Updated")
            }
            else {
                
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getFirst() -> NSManagedObject? {
        var match:NSManagedObject?
        let entityDescription = NSEntityDescription.entity(forEntityName: "Food", in: managedObjectContext!)
        let request: NSFetchRequest<Food> = Person.fetchRequest() as! NSFetchRequest<Food>
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
        } catch let _ as NSError {
            
        }
    }
    
    func addFood(name: String, calorie: Double, fat: Double, sugar: Double, protein: Double, carb: Double, detail: String, pimage: UIImage){
        let entity = NSEntityDescription.entity(forEntityName: "Food", in: self.managedObjectContext!)
        let added = Food(entity: entity!, insertInto: managedObjectContext)
        
        added.name = name
        added.calorie = calorie
        added.fat = fat
        added.sugar = sugar
        added.protein = protein
        added.carb = carb
        added.detail = detail
        added.image = pimage.pngData() as? Data
        
        do{
            try managedObjectContext!.save()
            print("Food Added Succesfuly")
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
