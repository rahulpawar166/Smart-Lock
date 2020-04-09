//
//  LoginVCViewController.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 11/03/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseAuth
import AnimatedGradientView

class LoginVC: UIViewController {

    @IBOutlet weak var emailIdTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    let userDefaults = UserDefaults.standard
  
    
    @IBOutlet weak var animateView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
        
//        emailIdTF.attributedPlaceholder = [NSAttributedString.Key.foregroundColor=UIColor.FlatBlack()]
        
               let animatedGradient = AnimatedGradientView(frame: view.bounds)
               animatedGradient.direction = .up
               animatedGradient.animationValues = [(colors: ["#2BC0E4", "#F7D80F"], .up, .axial),
        //                                        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial)]
        //     (colors: ["#003973", "#E5E5BE"], .down, .axial)]
              (colors: ["#f5e76e", "#f7d04d", "#fcb03d"], .left, .axial)]
                animateView.addSubview(animatedGradient)
        
       //MARK :- Text Field effects
        
       
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.bool(forKey: "userSignedIn") {
             performSegue(withIdentifier: "goToHomeVC", sender: self)
        }
    }
    
    @IBAction func loginTapped(_ sender: UITapGestureRecognizer) {
        signinUser(email: emailIdTF.text!, password: passwordTF.text!)
    }
    
//    @IBAction func loginPressed(_ sender: UIButton) {
//        signinUser(email: emailIdTF.text!, password: passwordTF.text!)
//    }
    
//    @IBAction func phoneLoginTapped(_ sender: UITapGestureRecognizer) {
//
//        performSegue(withIdentifier: "goToPhoneLoginVC", sender: self)
//    }
    


 
    
    
    func createUser(email: String, password: String){
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("User created successfull")
                //Sign in
                self.signinUser(email: email, password: password)
            }else {
                print("Error while user creation in,\(error?.localizedDescription)")
            }
        }
    }
    
    func signinUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email , password: password) { ( user, error) in
            if error == nil{
                
//                let mainTabBarController = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
//                self.show(mainTabBarController, sender: self)
                
                self.performSegue(withIdentifier: "goToHomeVC", sender: self)
                
                print("User signed in")
                self.userDefaults.set(true, forKey:"userSignedIn")
                self.userDefaults.synchronize()
            
                
                
            }else if(error?._code == AuthErrorCode.userNotFound.rawValue){
                self.createUser(email: email, password: password)
            }else {
                print(error)
                print(error?.localizedDescription)
            }
        }
    
    }
    
}
