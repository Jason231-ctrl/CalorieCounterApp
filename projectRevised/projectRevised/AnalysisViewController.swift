//
//  AnalysisViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import UIKit

class AnalysisViewController: UIViewController {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodModel:FoodModel?
    var personModel:PersonModel?
    var logsModel:LogsModel?
    var foodList:foodLogs = foodLogs()
    var itemList:foodItem = foodItem()
    var fatTotal:Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        foodModel = FoodModel(context: managedObjectContext)
        personModel = PersonModel(context: managedObjectContext)
        logsModel = LogsModel(context: managedObjectContext)
        // Do any additional setup after loading the view.
        for i in 0..<(logsModel?.getSize())!{
            let named = foodModel?.getResults(i: i)?.value(forKey: "name") as! String
            let detailed = foodModel?.getResults(i: i)?.value(forKey: "detail") as! String
            let caloried = foodModel?.getResults(i: i)?.value(forKey: "calorie") as! Double
            let carbd = foodModel?.getResults(i: i)?.value(forKey: "carb") as! Double
            let fatd = foodModel?.getResults(i: i)?.value(forKey: "fat") as! Double
            let protd = foodModel?.getResults(i: i)?.value(forKey: "protein") as! Double
            let sugd = foodModel?.getResults(i: i)?.value(forKey: "sugar") as! Double
            itemList.addItem(iname: named, ical: caloried, icarb: carbd, ifat: fatd, ipro: protd, isug: sugd, idet: detailed, iimg: Data())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
