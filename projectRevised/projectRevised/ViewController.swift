//
//  ViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//

import UIKit

class ViewController: UIViewController {

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodModel:FoodModel?
    var personModel:PersonModel?
    var logsModel:LogsModel?
    @IBOutlet weak var dietLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        foodModel = FoodModel(context: managedObjectContext)
        personModel = PersonModel(context: managedObjectContext)
        logsModel = LogsModel(context: managedObjectContext)
        //print(personModel?.getPerson(diet: "Keto"))
        /*print(personModel?.getPerson(diet: "Vegan"))
        print(personModel?.getPerson(diet: "Paleo"))
        print(personModel?.getPerson(diet: "Low-Carb"))
        print(personModel?.getPerson(diet: "Other"))
         */
        let date = Date()
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = components.hour
        let minuite = components.minute
        //print(hour!)
        //print(minuite!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dietLabel.text = personModel?.getPersonFirst()?.value(forKey: "diet") as? String
    }
    @IBAction func foodDiaryButton(_ sender: Any) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date)
        if(dateString != logsModel?.getFirstLog()?.value(forKey: "date") as? String){
            logsModel?.cleardata()
            foodModel?.cleardata()
        }
    }
    @IBAction func clearFood(_ sender: Any) {
        foodModel?.cleardata()
        logsModel?.cleardata()
        personModel?.cleardata()
        dietLabel.text = ""
        //print(logsModel?.getSize()! ?? 0)
    }
    
    @IBAction func returned(segue: UIStoryboardSegue){
        if let sourceViewController = segue.source as? MapViewController {
            print("returned from map")
        }
        if let sourceViewController = segue.source as? SetUpViewController {
            print("returned from setup")
        }
        if let souceViewController = segue.source as? DiaryViewController {
            print("returned from food planner")
        }
        if let sourceViewController = segue.source as? AnalysisViewController{
            print("returned from analysis")
        }
        if let sourceViewController = segue.source as? RecipeViewController{
            print("return from recipies")
        }
    }
    


}

