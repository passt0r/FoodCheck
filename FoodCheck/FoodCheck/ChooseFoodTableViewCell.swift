//
//  ChooseFoodTableViewCell.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 17.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class ChooseFoodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodIcon: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cell = UIImageView(image: #imageLiteral(resourceName: "shelf_cell_2"))
        cell.clipsToBounds = true
        self.backgroundView = cell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
