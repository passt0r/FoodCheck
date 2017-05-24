//
//  YourFoodTableViewCell.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 20.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class YourFoodTableViewCell: UITableViewCell {
    @IBOutlet private weak var foodItemCollection: UICollectionView! //collectionView with food item
    
    func foodCollectionConfiguration<T: UICollectionViewDelegate & UICollectionViewDataSource>(withDataSourceAndDelegate configurator: T, forRow row: Int) {
        
        foodItemCollection.delegate = configurator
        foodItemCollection.dataSource = configurator
        foodItemCollection.tag = row
        foodItemCollection.reloadData()
        
    }

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
