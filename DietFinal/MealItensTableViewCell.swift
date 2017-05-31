//
//  MealItensTableViewCell.swift
//  MyDiet
//
//  Created by Rafael Cunha on 15/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class MealItensTableViewCell: UITableViewCell {

    @IBOutlet weak var itemField: UILabel!
    @IBOutlet weak var unityFIeld: UILabel!
    @IBOutlet weak var quantityFIeld: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
