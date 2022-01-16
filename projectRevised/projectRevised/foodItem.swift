//
//  foodItem.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import Foundation
import UIKit

class foodItem{
    var foodItem:[itemObj] = []
    var itemList = [String: [itemObj]]()
    let sections = ["Breakfast","Lunch","Dinner"]
    init(){
        
    }
    func getSecCount() -> Int?{
        return sections.count
    }
    
    func getSecTitle(sectionNo: Int) -> String? {
        return sections[sectionNo]
    }
    
    func getSecCount(key: String) -> Int? {
        return itemList[key]?.count
    }
    
    func getItem(key:String, item:Int) -> itemObj?{
        if let itemValue = itemList[key]{
            return itemValue[item]
        } else {
            return nil
        }
    }
    
    func addItem(iname:String, ical:Double, icarb:Double, ifat:Double, ipro:Double, isug:Double, idet:String, iimg:Data){
        let i = itemObj(name: iname, cal: ical, carb: icarb, fat: ifat, pro: ipro, sug: isug, det: idet, img: Data())
        foodItem.append(i)
    }
    
    func updateImage(key:String, item:Int, img: Data){
        if let itemValue = itemList[key]{
            itemValue[item].itemImage = img
        } else {
            // nothing
        }
    }
    
    func removeFood(section: Int, index: Int){
        self.itemList[sections[section]]?.remove(at: index)
    }
}

class itemObj{
    var itemName:String
    var itemCal:Double
    var itemCarb:Double
    var itemFat:Double
    var itemPro:Double
    var itemSug:Double
    var itemDet:String
    var itemImage:Data
    
    init(name:String, cal:Double, carb:Double, fat:Double, pro:Double, sug:Double, det:String, img:Data){
        itemName = name
        itemCal = cal
        itemCarb = carb
        itemFat = fat
        itemPro = pro
        itemSug = sug
        itemDet = det
        itemImage = img
    }
}
