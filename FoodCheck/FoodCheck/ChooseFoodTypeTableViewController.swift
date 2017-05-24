//
//  ChooseFoodTypeTableViewController.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 17.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift

class ChooseFoodTypeTableViewController: UITableViewController {
    
    let foodTypes: [FoodType]
    var selectedType: FoodType?
    
    required init?(coder aDecoder: NSCoder) {
        let pathToTypesDB = Bundle.main.url(forResource: "release", withExtension: "realm")
        var configurator = Realm.Configuration()
        configurator.fileURL = pathToTypesDB
        configurator.readOnly = true
        
        let dataBase = try! Realm(configuration: configurator)
        let types = dataBase.objects(FoodType.self)
        var allTypes = [FoodType]()
        for type in types {
            allTypes.append(type)
        }
        foodTypes = allTypes
        
        super.init(coder: aDecoder)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))

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
        return foodTypes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = foodTypes[indexPath.row]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodType", for: indexPath) as! ChooseFoodTableViewCell
        let typeItem = foodTypes[indexPath.row]
        let foodIcon = UIImage(named: typeItem.logotipe)
        cell.foodIcon.image = foodIcon
        cell.foodName.text = typeItem.name

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
        let choosedTypeCell = sender as! ChooseFoodTableViewCell
        guard let selectedIndex = tableView.indexPath(for: choosedTypeCell) else {fatalError("Unexpected segue sender")}
        let selectedType = foodTypes[selectedIndex.row].type
        let destinationViewController = segue.destination as! ChooseFoodTableViewController
        destinationViewController.availableFood.removeAll()
        let dataBase = try! Realm(configuration: getReleaseDB())
        let predicate = NSPredicate(format: "type = %@", selectedType)
        let availableMeals = dataBase.objects(FoodItem.self).filter(predicate)
        //let availableMeals = dataBase.objects(FoodItem.self)
        for meal in availableMeals {
            destinationViewController.availableFood.append(meal)
        }
        
    }
    

}
