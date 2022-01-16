//
//  CalorieModel.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import Foundation
public class CalorieModel{
    var calorie:Double?
    var calorieAsString:String?
    func mifflinFormula(height: Double, weight: Double, age:Double) -> Double?{
        calorie = 10*weight +  6.25*height - 5*age - 156
        calorieAsString = "\(String(describing: calorie))"
        return calorie
    }
    
    func harrisBeneditctFormula(height:Double, weight:Double, age:Double) -> Double?{
        calorie = 66 + (6.23*weight) + (12.7*height) - (6.8*age)
        calorieAsString = "\(String(describing: calorie))"
        return calorie
    }
    func standardDietFormula() -> String?{
        return "2000.00"
    }
}
