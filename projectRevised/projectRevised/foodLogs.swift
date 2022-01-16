//
//  foodLogs.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import Foundation
import UIKit

class foodLogs{
    //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let logsModel:LogsModel?
    var foodLogs:[foodObj] = []
    var foodList = [String: [foodObj]]()
    let sections = ["Breakfast","Lunch","Dinner"]
    
    init(){
        //logsModel = LogsModel(context: managedObjectContext)
    }
    
    func getSecCount() -> Int?{
        return sections.count
    }
    
    func getSecTitle(sectionNo: Int) -> String? {
        return sections[sectionNo]
    }
    
    func getSecCount(key: String) -> Int? {
        return foodList[key]?.count
    }
    
    func getFood(key:String, item:Int) ->foodObj?{
        if let foodValue = foodList[key]{
            return foodValue[item]
        } else {
            return nil
        }
    }
    
    func addFood(fname:String, fCalorie: Double, fDate:String, fHour: Int32){
        let f = foodObj(name: fname, calories: fCalorie, date: fDate, hour: fHour)
        foodLogs.append(f)
        switch(fHour){
        case 0..<10:
            self.foodList["Breakfast"] = foodLogs
        case 10..<14:
            self.foodList["Lunch"] = foodLogs
        case 14..<24:
            self.foodList["Dinner"] = foodLogs
        default:
            self.foodList["Breakfast"] = foodLogs
        }
    }
    
    func removeFood(section: Int, index: Int){
        self.foodList[sections[section]]?.remove(at: index)
    }
    
}

class foodObj{
    var foodName:String
    var foodCalories:Double
    var foodDate:String
    var foodHour:Int32
    
    init(name:String, calories:Double, date:String, hour:Int32){
        foodName = name
        foodCalories = calories
        foodDate = date
        foodHour = hour
    }
}
