//
//  VerifyOtpVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 12/03/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class VerifyOtpVC: UIViewController {

    @IBOutlet weak var otpTF: UITextField!
    
    var phoneVC = PhoneVC()
    
    let userDefaults = UserDefaults.standard
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
     hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.bool(forKey: "userSignedIn") {
            performSegue(withIdentifier: "goToHomeVC", sender: self)
        }
    }
    
    @IBAction func verifyPressed(_ sender: UIButton) {
        sender.pulsate()
        guard let otpCode = otpTF.text else {return}
             
             guard let verificationID = userDefaults.string(forKey: "verificationID") else {return}
             
             let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
             
             Auth.auth().signInAndRetrieveData(with: credential) { (success, error) in
                 if error == nil {
                     print(success)
                     print("User signed in")
                    self.userDefaults.set(true, forKey:"userSignedIn")
                    self.userDefaults.synchronize()
                    self.performSegue(withIdentifier: "goToHomeVC", sender: self)
                 }else {
                     print("Something went wrong\(error?.localizedDescription)")
                 }
             }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
