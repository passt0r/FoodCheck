//
//  YourFoodTableViewController.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 20.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import RealmSwift

class YourFoodTableViewController: UITableViewController {
    
    private let cellIdentifier = "yourFoodCell"
    fileprivate let itemCellIdentifer = "itemCell"
    fileprivate let cellsInRow = Int(UIScreen.main.bounds.width)/60 //60 is width of 1 cell
    fileprivate var rowsInFridge = 0
    
    //array with elements from DB, need for graphic representation of this data in tableviewcells
    //var foodItems = [[FoodItemInFridge]]()
    
    var foodInFridge = [FoodItemInFridge]()
    
    
    //MARK: - debug test methods
    //MARK: for foodItems property
    /*
    func generateTestFood(withDB dataBase: Realm) {
        let milk = FoodType()
        milk.name = "Milk"
        milk.chooseType(ofType: .milk)
        milk.chooseLogo(ofType: .milk)
        let meat = FoodType()
        meat.name = "Meat"
        meat.chooseType(ofType: .meet)
        meat.chooseLogo(ofType: .meet)
        let vegi = FoodType()
        vegi.name = "Vegitables"
        vegi.chooseType(ofType: .test)
        vegi.chooseLogo(ofType: .test)
        let bread = FoodType()
        bread.name = "Bread"
        bread.chooseType(ofType: .bread)
        bread.chooseLogo(ofType: .bread)
        
        let freshBread = FoodItem()
        freshBread.name = "Fresh Bread"
        freshBread.shelfLife = 12345
        freshBread.chooseLogo(ofType: .bread)
        freshBread.chooseType(ofType: .bread)
        try! dataBase.write {
            dataBase.add(milk)
            dataBase.add(meat)
            dataBase.add(vegi)
            dataBase.add(bread)
            dataBase.add(freshBread)
        }
        for _ in 0...4 {
            var newItems = [FoodItemInFridge]()
            for _ in 0...4 {
                let testItem = FoodItemInFridge()
                testItem.name = "Test"
                testItem.chooseType(ofType: .bread)
                newItems.append(testItem)
                try! dataBase.write {
                    dataBase.add(testItem) //adding objects to DB
                }
            }
            foodItems.append(newItems)
        }
        
        var newRowItem = [FoodItemInFridge]()
        let newEl1 = FoodItemInFridge()
        newEl1.chooseType(ofType: .meet)
        newEl1.chooseLogo(ofType: .meet)
        newRowItem.append(newEl1)
        let newEl2 = FoodItemInFridge()
        newEl2.chooseType(ofType: .milk)
        newEl2.chooseLogo(ofType: .milk)
        newRowItem.append(newEl2)
        try! dataBase.write {
            dataBase.add(newEl1) //adding objects to DB
            dataBase.add(newEl2)
        }
        foodItems.append(newRowItem)
        
    }
    
    func deleteData(from dataBase: Realm){
        try! dataBase.write {
            dataBase.deleteAll()
        }
    }
    
    //MARK: - working with data
    func readData(from dataBase: Realm) {
        let userFood = dataBase.objects(FoodItemInFridge.self)
        var rows = userFood.count/cellsInRow
        if userFood.count%cellsInRow != 0 {
            rows += 1
        }
        /*
        for row in 0..<rows {
            var newItems = [FoodItemInFridge]()
            for item in 0..<cellsInRow {
                let index = (row*cellsInRow) + item
                newItems.append(userFood[index])
            }
            foodItems.append(newItems)
        } */
        var itemsInRow = 0
        var foodRow = [FoodItemInFridge]()
        for foodItem in userFood {
            if itemsInRow < 5 {
                itemsInRow += 1
                foodRow.append(foodItem)
            } else {
                itemsInRow = 0
                foodItems.append(foodRow)
                foodRow.removeAll()
            }
            
        }
        foodItems.append(foodRow)
        
    }
    */
    
    //MARK: - for foodInFridge property
    
    func generateTestFood(withDB dataBase: Realm) {
        
        let milk = FoodType()
        milk.name = "Milk"
        milk.chooseType(ofType: .milk)
        milk.chooseLogo(ofType: .milk)
        let meat = FoodType()
        meat.name = "Meat"
        meat.chooseType(ofType: .meet)
        meat.chooseLogo(ofType: .meet)
        let vegi = FoodType()
        vegi.name = "Vegitables"
        vegi.chooseType(ofType: .test)
        vegi.chooseLogo(ofType: .test)
        let bread = FoodType()
        bread.name = "Bread"
        bread.chooseType(ofType: .bread)
        bread.chooseLogo(ofType: .bread)
        
        let freshBread = FoodItem()
        freshBread.name = "Fresh Bread"
        freshBread.shelfLife = 800
        freshBread.chooseType(ofType: .bread)
        let freshMilk = FoodItem()
        freshMilk.name = "Milk"
        freshMilk.shelfLife = 1200
        freshMilk.chooseType(ofType: .milk)
        freshMilk.chooseLogo(ofType: .milk)
        
        try! dataBase.write {
            dataBase.add(milk)
            dataBase.add(meat)
            dataBase.add(vegi)
            dataBase.add(bread)
            dataBase.add(freshBread)
            dataBase.add(freshMilk)
        }
        
        for _ in 0..<25 {
            let testItem = FoodItemInFridge()
            testItem.name = "Test"
            testItem.chooseType(ofType: .bread)
            foodInFridge.append(testItem)
            try! dataBase.write {
                dataBase.add(testItem) //adding objects to DB
            }
        }
        
            let newEl1 = FoodItemInFridge()
            newEl1.chooseType(ofType: .meet)
            newEl1.chooseLogo(ofType: .meet)
            newEl1.endDate = NSDate(timeIntervalSinceNow: 10)
            foodInFridge.append(newEl1)
            let newEl2 = FoodItemInFridge()
            newEl2.chooseType(ofType: .milk)
            newEl2.chooseLogo(ofType: .milk)
            newEl2.endDate = NSDate(timeIntervalSinceNow: 12345)
            foodInFridge.append(newEl2)
            let newEl3 = FoodItemInFridge()
            newEl3.chooseType(ofType: .fish)
            newEl3.chooseLogo(ofType: .fish)
            newEl3.endDate = NSDate(timeIntervalSinceNow: 1000)
            foodInFridge.append(newEl3)
            try! dataBase.write {
                dataBase.add(newEl1) //adding objects to DB
                dataBase.add(newEl2)
                dataBase.add(newEl3)
            }
        findRowsCount()

    }
    func setupInapp(withName name: String) {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(name).realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    func deleteData(from dataBase: Realm){
        try! dataBase.write {
            dataBase.deleteAll()
        }
        foodInFridge.removeAll()
    }
    
    //MARK: - working with data
    func findRowsCount() {
        rowsInFridge = foodInFridge.count/cellsInRow
        if foodInFridge.count%cellsInRow != 0 {
            rowsInFridge += 1
        }
    }
    
    func readData(from dataBase: Realm) {
        let userFood = dataBase.objects(FoodItemInFridge.self).sorted(byKeyPath: "endDate", ascending: true)
        /*
        rowsInFridge = userFood.count/cellsInRow
        if userFood.count%cellsInRow != 0 {
            rowsInFridge += 1
        } */
        for foodItem in userFood {
            foodInFridge.append(foodItem)
        }
        findRowsCount()
        
    }
    /*
     func showOnEmptyTable(message: String) {

        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        //messageLabel.backgroundColor = UIColor(red: 0.235, green: 0.718, blue: 0.467, alpha: 1)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Helvetica Neue", size: 18)
        messageLabel.sizeToFit()

        self.tableView.backgroundView = messageLabel
        
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        #if PREPARE
            setupInapp(withName: "release")
        #endif
        let dataBase = try! Realm()
        
        //use this methods for debug
        #if DEBUG
            deleteData(from: dataBase)
            //generateTestFood(withDB: dataBase)
            //foodInFridge.removeAll()
            //readData(from: dataBase)
        #else
            readData(from: dataBase)
        #endif
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))
        
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if rowsInFridge > 0 {
            let background = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))
            background.sizeToFit()
            self.tableView.backgroundView = background
            return 1
        }
        else {
            showOnEmptyTable(message: "You have not add any food yet.\nTo add any food press add button")
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return foodItems.count  //for foodItems fridge representation
       
        return rowsInFridge     //for foodInFridge representation
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! YourFoodTableViewCell

        // Configure the cell...
        //cell.foodCollectionConfiguration(withDataSourceAndDelegate: self, forRow: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? YourFoodTableViewCell else {return}
        
        tableViewCell.foodCollectionConfiguration(withDataSourceAndDelegate: self, forRow: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
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
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToFridge(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        //let chooseFoodScreen = unwindSegue.source as! ChooseFoodTableViewController
        let dataBase = try! Realm()
        
        if unwindSegue.identifier == "qrReader" {
            let sourceViewController = unwindSegue.source as! ReadQRViewController
            let findedFood = sourceViewController.capturedFoodItem
            if let findedFood = findedFood {
                try! dataBase.write {
                    dataBase.add(findedFood)
                }
            }
        }
        
        foodInFridge.removeAll()
        readData(from: dataBase)
        self.tableView.reloadData()
        
    }

}

//MARK: - CollectionView delegate and datasource extention
extension YourFoodTableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        /*let screenWight = UIScreen.main.bounds.width
        let collectionCellWightWithSeparation = 60
        return Int(screenWight)/collectionCellWightWithSeparation
        */
        
        let foodWasRepresent = collectionView.tag*cellsInRow
        let itemsForSectionLeft = foodInFridge.count - foodWasRepresent
        if itemsForSectionLeft < cellsInRow {
            return itemsForSectionLeft
        } else {
            return cellsInRow
        }
        
        //return foodItems[collectionView.tag].count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifer, for: indexPath) as! FoodItemCollectionViewCell
        let itemCount = collectionView.tag*cellsInRow + indexPath.row
        //let logo = UIImageView(image: UIImage(named: foodItems[collectionView.tag][indexPath.row].logotipe))
        let logo = UIImageView(image: UIImage(named: foodInFridge[itemCount].logotipe))
        logo.clipsToBounds = true
        cell.backgroundView = logo
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        let selectedRow = foodItems[collectionView.tag]
        let selectedItem = selectedRow[indexPath.row]
        let dataBase = try! Realm()
        try! dataBase.write {
            dataBase.delete(selectedItem)
        }
        foodItems[collectionView.tag].remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        
        foodItems.removeAll()
        readData(from: dataBase)
        self.tableView.reloadData()
         */
        
        let selectedItemIndex = collectionView.tag*cellsInRow + indexPath.row
        let selectedItem = foodInFridge[selectedItemIndex]
        let dataBase = try! Realm()
        try! dataBase.write {
            dataBase.delete(selectedItem)
        }
        foodInFridge.remove(at: selectedItemIndex)
        findRowsCount()
        self.tableView.reloadData()
    }

    
}

extension UITableViewController {
    func showOnEmptyTable(message: String) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        //messageLabel.backgroundColor = UIColor(red: 0.235, green: 0.718, blue: 0.467, alpha: 1)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.init(name: "Helvetica Neue", size: 18)
        messageLabel.sizeToFit()

        self.tableView.backgroundView = messageLabel
    }

}
extension UIViewController {
    
    
    func preparedForFridge(food item: FoodItem) -> FoodItemInFridge {
        let fridgeItem = FoodItemInFridge()
        fridgeItem.name = item.name
        fridgeItem.type = item.type
        fridgeItem.logotipe = item.logotipe
        fridgeItem.endDate = NSDate(timeIntervalSinceNow: item.shelfLife)
        return fridgeItem
    }
    
    func getReleaseDB() -> Realm.Configuration {
        let pathToTypesDB = Bundle.main.url(forResource: "release", withExtension: "realm")
        var configurator = Realm.Configuration()
        configurator.fileURL = pathToTypesDB
        configurator.readOnly = true
        return configurator
    }
}
