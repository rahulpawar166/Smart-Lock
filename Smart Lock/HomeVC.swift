//
//  HomeVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 11/03/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeVC: UIViewController {

    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: "userSignedIn")
            userDefaults.synchronize()
//            self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "goToLoginVC", sender: self)
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    

}
