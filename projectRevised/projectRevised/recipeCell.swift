//
//  recipeCell.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import Foundation
import UIKit

class recipeCell:UITableViewCell{
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeServings: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
