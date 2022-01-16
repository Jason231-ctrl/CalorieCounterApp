//
//  loggedTableViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/13/21.
//

import UIKit

class loggedTableViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var foodModel:FoodModel?
    let picker = UIImagePickerController()
    @IBOutlet weak var imageSource: UISegmentedControl!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var calorieNumber: UILabel!
    @IBOutlet weak var carbNumber: UILabel!
    @IBOutlet weak var fatNumber: UILabel!
    @IBOutlet weak var proteinNumber: UILabel!
    @IBOutlet weak var sugarNumber: UILabel!
    @IBOutlet weak var detailText: UILabel!
    var foodNameString:String?
    var foodCalorie:String?
    var foodCarb:String?
    var foodFat:String?
    var foodProtein:String?
    var foodSugar:String?
    var foodDetail:String?
    var tempImage:UIImage?
    var foodImaged:Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        foodModel = FoodModel(context: managedObjectContext)
        foodName.text = foodNameString
        calorieNumber.text = foodCalorie
        carbNumber.text = foodCarb
        fatNumber.text = foodFat
        proteinNumber.text = foodProtein
        sugarNumber.text = foodSugar
        detailText.text = foodDetail
        foodImaged = foodModel?.findFood(name: foodNameString!)?.value(forKey: "image") as? Data
        if(foodImaged != nil){
            foodImage.image = UIImage(data: foodImaged!)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeImage(_ sender: Any) {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        picker .dismiss(animated: true, completion: nil)
        foodImage.image=info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        tempImage = foodImage.image
        foodImaged = tempImage?.pngData()
        foodModel?.updateImage(name: foodNameString!, image: foodImaged!)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

