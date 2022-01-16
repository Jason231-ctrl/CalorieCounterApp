//
//  loggedCell.swift
//  projectRevised
//
//  Created by Jason Leong on 11/14/21.
//

import UIKit

class loggedCell: UITableViewCell{
    @IBOutlet weak var loggedImage: UIImageView!{
        didSet {
            loggedImage.layer.cornerRadius = loggedImage.bounds.width/2
            loggedImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var loggedName: UILabel!
    @IBOutlet weak var loggedCalories: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
