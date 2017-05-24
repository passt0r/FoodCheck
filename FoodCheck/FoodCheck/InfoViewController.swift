//
//  InfoViewController.swift
//  FoodCheck
//
//  Created by Dmytro Pasinchuk on 21.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginStatus: UILabel!
    @IBOutlet weak var statusBackgroundView: UIView!

    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var createdByLabel: UILabel!
    
    var isLogged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding background image to view
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "fridge_back"))
        backgroundImage.frame = UIScreen.main.bounds
        view.insertSubview(backgroundImage, at: 0)
        view.clipsToBounds = true
        
        infoText.layer.cornerRadius = 10
        createdByLabel.layer.masksToBounds = true
        createdByLabel.layer.cornerRadius = 10
        statusBackgroundView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 10
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissInfo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changeLoginStatus(_ sender: Any) {
        if isLogged == true {
            loginStatus.text = "Logout"
            loginStatus.textColor = UIColor.red
            loginButton.setTitle("Login", for: .normal)
            loginButton.setTitleColor(UIColor.green, for: .normal)
            isLogged = false
        } else {
            loginStatus.text = "Logged"
            loginStatus.textColor = UIColor.green
            loginButton.setTitle("Logout", for: .normal)
            loginButton.setTitleColor(UIColor.red, for: .normal)
            isLogged = true
            
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
