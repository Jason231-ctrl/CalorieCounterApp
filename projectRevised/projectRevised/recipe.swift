//
//  recipe.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import Foundation
class recipe{
    var recipe:[recipeFormat] = []
    init(){
        
    }
    func getCount() -> Int{
        return recipe.count
    }
    func getRecipe(item:Int) -> recipeFormat{
        return recipe[item]
    }
    func removeRecipe(item:Int){
        recipe.remove(at: item)
    }
    func addRecipe(id:Int, title:String, rim:Int, serv:Int, url:String, open:Int, image:String) -> recipeFormat{
        let r = recipeFormat(fid: id, ftitle: title, frim: rim, fserv: serv, furl: url, fopen: open, fimage: image)
        recipe.append(r)
        return r
    }
}

class recipeFormat{
    var id:Int?
    var title:String?
    var readyInMinuites:Int?
    var servings:Int?
    var sourceURL:String?
    var openLicense:Int?
    var image:String?
    
    init(fid:Int, ftitle:String, frim:Int, fserv:Int, furl:String, fopen:Int, fimage:String){
        id = fid
        title = ftitle
        readyInMinuites = frim
        servings = fserv
        sourceURL = furl
        openLicense = fopen
        image = fimage
    }
}
