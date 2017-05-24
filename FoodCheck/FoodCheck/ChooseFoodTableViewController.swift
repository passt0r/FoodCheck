//
//  ChooseFoodTableViewController.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 17.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseFoodTableViewController: UITableViewController {
    
    //Why it can be implement in required init? 
    var availableFood: [FoodItem] = [FoodItem]()
    var choosedFood: FoodItem?
    
    /*
     required init?(coder aDecoder: NSCoder) {
        //guard let choosedFoodType = choosedFoodType else { fatalError("Can't get food type") }
        guard let choosedType = choosedFoodType.type else { fatalError("Can't get food type") }
        let dataBase = try! Realm()
        let predicate = NSPredicate(format: "type = %@", choosedType)
        let availableMeals = dataBase.objects(FoodItem.self).filter(predicate)
        var readedMealList = [FoodItem]()
        for meal in availableMeals {
            readedMealList.append(meal)
        }
        availableFood = readedMealList
        
        super.init(coder: aDecoder)
    } 
    */
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))
        
        if availableFood.isEmpty {
            showOnEmptyTable(message: "No food of such type is available for now")
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return availableFood.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosedFood = availableFood[indexPath.row]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodItem", for: indexPath) as! ChooseFoodTableViewCell

        // Configure the cell...
        let foodItem = availableFood[indexPath.row]
        let foodIcon = UIImage(named: foodItem.logotipe)
        cell.foodIcon.image = foodIcon
        cell.foodName.text = foodItem.name
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let selectedCell = sender as! ChooseFoodTableViewCell
        let indexPath = tableView.indexPath(for: selectedCell)!
        choosedFood = availableFood[indexPath.row]
        let dataBase = try! Realm()
        if let choosedFood = choosedFood {
            let foodToFridge = preparedForFridge(food: choosedFood)
            try! dataBase.write {
                dataBase.add(foodToFridge)
            }
        }
        //let destinationViewController = segue.destination as! YourFoodTableViewController
        //destinationViewController.foodInFridge.removeAll()
        //destinationViewController.readData(from: dataBase)
        //destinationViewController.tableView.reloadData()

    }
    

}
