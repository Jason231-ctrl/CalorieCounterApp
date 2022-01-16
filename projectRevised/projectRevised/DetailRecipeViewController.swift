//
//  DetailRecipeViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import UIKit

class DetailRecipeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var recipeList2:recipe = recipe()
    @IBOutlet weak var recipeTable2: UITableView!
    var number:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeList2.getCount()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        number = indexPath.row
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeCell
        cell.layer.borderWidth = 1.0
        let cellItem = recipeList2.getRecipe(item: indexPath.row)
        cell.recipeName.text = cellItem.title
        cell.recipeServings.text = cellItem.sourceURL
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        recipeList2.removeRecipe(item: indexPath.row)
        self.recipeTable2.beginUpdates()
        self.recipeTable2.deleteRows(at: [indexPath], with: .automatic)
        self.recipeTable2.endUpdates()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toOnlineView"){
            let selectedIndex: IndexPath = self.recipeTable2.indexPath(for: sender as! UITableViewCell)!
            let recipe = recipeList2.getRecipe(item: selectedIndex.row)
            if let viewController: OnlineViewController =  segue.destination as? OnlineViewController {
                viewController.selected = recipe.sourceURL
            }
        }
    }
    
    @IBAction func returned4(segue: UIStoryboardSegue){
        if let sourceViewController = segue.source as? OnlineViewController{
            print("from Online View Contoller")
        }
    }
}
