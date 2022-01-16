//
//  DiaryViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import UIKit

class DiaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodModel:FoodModel?
    var personModel:PersonModel?
    var logsModel:LogsModel?
    var savedNumber:Int?
    @IBOutlet weak var loggedTable: UITableView!
    @IBOutlet weak var formulaChooser: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calorieTotal: UILabel!
    @IBOutlet weak var calorieUsed: UILabel!
    @IBOutlet weak var calorieRemaining: UILabel!
    var calorieUsedNumber:Int = 0
    var calorieRemaningNumber:Int = 0
    var calorieTotalNumber:Double = 0
    let cm = CalorieModel()
    var dateString:String?
    var foodList:foodLogs = foodLogs()
    var itemList:foodItem = foodItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        foodModel = FoodModel(context: managedObjectContext)
        personModel = PersonModel(context: managedObjectContext)
        logsModel = LogsModel(context: managedObjectContext)
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateString = dateFormatter.string(from: date)
        dateLabel.text = dateFormatter.string(from: date)
        print(dateString!)
        let heightP = personModel?.getPersonFirst()!.value(forKey: "height") as! Double
        let weightP = personModel?.getPersonFirst()!.value(forKey: "weight") as! Double
        let ageP = personModel?.getPersonFirst()!.value(forKey: "age") as! Double
        calorieTotal.text = "\(cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!)"
        calorieTotalNumber = cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!
        for i in 0..<(logsModel?.getSize())!{
            let named = logsModel?.getResults(i: i)?.value(forKey: "name") as! String
            let caloried = logsModel?.getResults(i: i)?.value(forKey: "calories") as! Double
            let dated = logsModel?.getResults(i: i)?.value(forKey: "date") as! String
            let hourd = logsModel?.getResults(i: i)?.value(forKey: "hour") as! Int32
            foodList.addFood(fname: named, fCalorie: caloried, fDate: dated, fHour: hourd)
            calorieUsedNumber = calorieUsedNumber + Int(caloried)
        }
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
        // this function makes it reset daily
        if(dateString != logsModel?.getFirstLog()?.value(forKey: "date") as? String){
            logsModel?.cleardata()
            foodModel?.cleardata()
        }
        calorieRemaningNumber = Int(calorieTotalNumber) - calorieUsedNumber
        calorieRemaining.text = "\(calorieRemaningNumber)"
        calorieUsed.text = "\(calorieUsedNumber)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodList.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return foodList.sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        savedNumber = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let foodKey = foodList.sections[section]
        if let count = foodList.getSecCount(key: foodKey){
            return count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = loggedTable.dequeueReusableCell(withIdentifier: "loggedCell", for: indexPath) as! loggedCell
        cell.layer.borderWidth = 1.0
        let foodKey = foodList.sections[indexPath.section]
        let item = itemList.foodItem[indexPath.row]
        if let food = foodList.getFood(key: foodKey, item: indexPath.row){
            cell.loggedImage.image = UIImage(data: item.itemImage)
            cell.loggedName.text = food.foodName
            cell.loggedCalories.text = "\(food.foodCalories)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.loggedTable.beginUpdates()
        self.foodList.removeFood(section: indexPath.section, index: indexPath.row)
        self.itemList.removeFood(section: indexPath.section, index: indexPath.row)
        self.loggedTable.deleteRows(at: [indexPath], with: .fade)
        self.loggedTable.endUpdates()
    }
    
    @IBAction func pickFormula(_ sender: Any) {
        switch(formulaChooser.selectedSegmentIndex){
        case 0:
            let heightP = personModel?.getPersonFirst()!.value(forKey: "height") as! Double
            let weightP = personModel?.getPersonFirst()!.value(forKey: "weight") as! Double
            let ageP = personModel?.getPersonFirst()!.value(forKey: "age") as! Double
            calorieTotal.text = "\(cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!)"
            calorieTotalNumber = cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!
            calorieRemaningNumber = Int(calorieTotalNumber) - calorieUsedNumber
            calorieRemaining.text = "\(calorieRemaningNumber)"
            calorieUsed.text = "\(calorieUsedNumber)"
        case 1:
            let heightP = personModel?.getPersonFirst()!.value(forKey: "height") as! Double
            let weightP = personModel?.getPersonFirst()!.value(forKey: "weight") as! Double
            let ageP = personModel?.getPersonFirst()!.value(forKey: "age") as! Double
            calorieTotal.text = "\(cm.harrisBeneditctFormula(height: heightP, weight: weightP, age: ageP)!)"
            calorieTotalNumber = cm.harrisBeneditctFormula(height: heightP, weight: weightP, age: ageP)!
            calorieRemaningNumber = Int(calorieTotalNumber) - calorieUsedNumber
            calorieRemaining.text = "\(calorieRemaningNumber)"
            calorieUsed.text = "\(calorieUsedNumber)"
        case 2:
            calorieTotal.text = cm.standardDietFormula()
            calorieTotalNumber = 2000
            calorieRemaningNumber = Int(calorieTotalNumber) - calorieUsedNumber
            calorieRemaining.text = "\(calorieRemaningNumber)"
            calorieUsed.text = "\(calorieUsedNumber)"
        default:
            let heightP = personModel?.getPersonFirst()!.value(forKey: "height") as! Double
            let weightP = personModel?.getPersonFirst()!.value(forKey: "weight") as! Double
            let ageP = personModel?.getPersonFirst()!.value(forKey: "age") as! Double
            calorieTotal.text = "\(cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!)"
            calorieTotalNumber = cm.mifflinFormula(height: heightP, weight: weightP, age: ageP)!
            calorieRemaningNumber = Int(calorieTotalNumber) - calorieUsedNumber
            calorieRemaining.text = "\(calorieRemaningNumber)"
            calorieUsed.text = "\(calorieUsedNumber)"
        }
    }
    
    @IBAction func newLog(_ sender: Any) {
        let date = Date()
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = components.hour
        let alert = UIAlertController(title: "Add Food", message: nil, preferredStyle: .alert)
        let additionAction = UIAlertAction(title: "Add", style: .default) {(action) in
            let name = alert.textFields![0] as UITextField
            let calorie = alert.textFields![1] as UITextField
            let fat = alert.textFields![2] as UITextField
            let sugar = alert.textFields![3] as UITextField
            let protein = alert.textFields![4] as UITextField
            let carb = alert.textFields![5] as UITextField
            let detail = alert.textFields![6] as UITextField
            self.foodModel?.addFood(name: name.text!, calorie: Double(calorie.text!)!, fat: Double(fat.text!)!, sugar: Double(sugar.text!)!, protein: Double(protein.text!)!, carb: Double(carb.text!)!, detail: detail.text!, pimage: UIImage())
            self.logsModel?.addLog(name: name.text!, date: self.dateString!, hour: Int32(hour!), calorie: Double(calorie.text!)!)
            self.foodList.addFood(fname: name.text!, fCalorie: Double(calorie.text!)!, fDate: self.dateString!, fHour: Int32(hour!))
            self.itemList.addItem(iname: name.text!, ical: Double(calorie.text!)!, icarb: Double(carb.text!)!, ifat: Double(fat.text!)!, ipro: Double(protein.text!)!, isug: Double(sugar.text!)!, idet: detail.text!, iimg: Data())
            self.calorieUsedNumber = self.calorieUsedNumber + Int(calorie.text!)!
            self.calorieRemaningNumber = Int(self.calorieTotalNumber) - self.calorieUsedNumber
            self.calorieRemaining.text = "\(self.calorieRemaningNumber)"
            self.calorieUsed.text = "\(self.calorieUsedNumber)"
            self.loggedTable.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action) in
        }
        alert.addTextField{(textField) in
            textField.placeholder = "name"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "calorie"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "fat"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "sugar"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "protein"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "carb"
            textField.textAlignment = .center
        }
        alert.addTextField{(textField) in
            textField.placeholder = "detail"
            textField.textAlignment = .center
        }
        alert.addAction(additionAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        self.loggedTable.reloadData()
        
    }
    
    @IBAction func helpButton(_ sender: Any) {
        let date = Date()
        let components = Calendar.current.dateComponents([.hour,.minute], from: date)
        let hour = components.hour
        print(hour!)
        let alert = UIAlertController(title: "Help", message: """
        Need help choosing which one is perfect for you?
        
        Either one is fine, they vary from one to another slightly but here is some brief info.
        
        Mifflin St. Jeor's method: Created in the 1990s calculates your basal metabolic results.
        
        Harris-Benedict: started in 1919 then revised in 1989, another way to calculate basal metabolic results.
        
        StandardDiet: is a standard american diet of average 2000 Calorie Diet.
        """, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
        //print(foodModel?.getFirst()?.value(forKey: "image"))
        
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "toDetailCell"){
            let selectedIndex: IndexPath = self.loggedTable.indexPath(for: sender as! UITableViewCell)!
            let item = itemList.foodItem[selectedIndex.row]
            if let viewController: loggedTableViewController = segue.destination as? loggedTableViewController {
                viewController.foodNameString = item.itemName
                viewController.foodCalorie = "\(item.itemCal)"
                viewController.foodCarb = "\(item.itemCarb)"
                viewController.foodFat = "\(item.itemFat)"
                viewController.foodSugar = "\(item.itemSug)"
                viewController.foodProtein = "\(item.itemPro)"
                viewController.foodDetail = item.itemDet
                viewController.foodImaged = item.itemImage
            }
        }
    }
    
    @IBAction func returned2(segue: UIStoryboardSegue){
        if let sourceViewController = segue.source as? loggedTableViewController {
            itemList.foodItem[savedNumber!].itemImage = sourceViewController.foodImaged!
            self.loggedTable.reloadData()
            print("from new table log")
        }
    }

}
