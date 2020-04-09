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
   
    @IBAction func callTapped(_ sender: UILongPressGestureRecognizer) {
        performSegue(withIdentifier: "goToHistoryVC", sender: self)
    }
   
    
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do{
                      try Auth.auth().signOut()
                      userDefaults.removeObject(forKey: "userSignedIn")
                      userDefaults.synchronize()
            
                    print("User Signed Out")
//         self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true) {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let loginVC = storyboard.instantiateViewController(identifier: "LoginVC") as! LoginVC
//
//                self.navigationController?.pushViewController(loginVC, animated: true)
//
//            }
            let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            self.show(loginVC, sender: self)

                  
                      
              }   catch let error as NSError{
                      print(error.localizedDescription)
                  }
    }
    
  

    

}
