//
//  RecipeViewController.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import UIKit

class RecipeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var recipeTable: UITableView!
    var recipeList:recipe = recipe()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeList.getCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! recipeCell
        cell.layer.borderWidth = 1.0
        let cellItem = recipeList.getRecipe(item: indexPath.row)
        cell.recipeImage.image = UIImage(named: cellItem.image!)
        cell.recipeName.text = cellItem.title
        cell.recipeServings.text = "\(cellItem.servings)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        recipeList.removeRecipe(item: indexPath.row)
        self.recipeTable.beginUpdates()
        self.recipeTable.deleteRows(at: [indexPath], with: .automatic)
        self.recipeTable.endUpdates()
    }
    
    @IBAction func searchFood(_ sender: Any) {
        
        let headers = [
            "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
            "x-rapidapi-key": "91f659b7e7msh1be78724fb9348cp17aa98jsn4dd50b5b3c1a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=\(searchText.text!)&instructionsRequired=true")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                //let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
                var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                let results = jsonResult["results"]! as! NSArray
                for i in 0...results.count-1{
                    let current = results[i] as? [String : AnyObject]
                    self.recipeList.addRecipe(id: current!["id"] as? Int ?? 0, title: (current!["title"] as? String) ?? "Not Available", rim: current!["readyInMinuites"] as? Int ?? 0, serv: current!["servings"] as? Int ?? 0, url: (current!["sourceUrl"] as? String) ?? "Not Avaliable", open: current!["openLicense"] as? Int ?? 0, image: (current!["image"] as? String) ?? "Not Avaliable")
                }
                for i in 1...self.recipeList.getCount()-1{
                print(self.recipeList.recipe[i].title)
                print(self.recipeList.recipe[i].servings)
                print(self.recipeList.recipe[i].sourceURL)
                print(self.recipeList.recipe[i].image)
                }
                //print(jsonResult)
            }
        })

        dataTask.resume()
        recipeTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toRecipeDetail"){
            if let viewController: DetailRecipeViewController = segue.destination as? DetailRecipeViewController{
                viewController.recipeList2 = recipeList
            }
        }
    }
    
    @IBAction func returned3(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? DetailRecipeViewController{
            print("coming from detailed recipe")
        }
    }
    
}
