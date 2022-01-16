//
//  SetUpViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/11/21.
//

import UIKit

class SetUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var heightLabel: UITextField!
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet var ageLabel: UITextField!
    @IBOutlet var iweightLabel: UITextField!
    @IBOutlet weak var dietPicker: UIPickerView!
    
    let managedObjetContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var setPerson:PersonModel?
    var dietType:String?
    let choice:[String] = ["Keto","Vegan","Paleo","Low-Carb","Other"]
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        setPerson = PersonModel(context: managedObjetContext)
        let rec = setPerson?.getPersonFirst()
        heightLabel.text = String(rec?.value(forKey: "height") as? Double ?? 0)
        weightLabel.text = String(rec?.value(forKey: "weight") as? Double ?? 0)
        iweightLabel.text = String(rec?.value(forKey: "iweight") as? Double ?? 0)
        ageLabel.text = String(rec?.value(forKey: "age") as? Double ?? 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        choice.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(choice[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dietType = choice[row]
    }
    @IBAction func savePerson(_ sender: Any) {
        if(iweightLabel.text=="" || heightLabel.text=="" || weightLabel.text=="" || ageLabel.text==""){
            errorLabel.alpha = 1
            errorLabel.textColor = UIColor.red
            errorLabel.text = "Fields can't be empty"
        }
        else {
            setPerson?.cleardata()
            setPerson?.setPerson(age: Double(ageLabel.text!)!, diet: dietType ?? "Keto", height: Double(heightLabel.text!)!, iweight: Double(iweightLabel.text!)!, weight: Double(weightLabel.text!)!)
            //print("After Save: \(setPerson?.getPerson(diet: "Keto"))")
            performSegue(withIdentifier: "toMainMenu", sender: nil)
        }
    }
}
