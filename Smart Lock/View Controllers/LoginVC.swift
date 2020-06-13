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

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var visualBlur: UIVisualEffectView!
    @IBOutlet weak var emailIdTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
 
    @IBOutlet weak var emailTF: UITextField!
   
    
   
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailIdTF{
            passwordTF.becomeFirstResponder()
        }else if textField == passwordTF{
            passwordTF.resignFirstResponder()
        }else{
            emailTF.resignFirstResponder()
        }
        return true
    }
    
    let userDefaults = UserDefaults.standard
  
    
    @IBOutlet weak var animateView: UIImageView!
    
    @IBOutlet weak var animatedViewOnBlur: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
      
        
//        emailIdTF.attributedPlaceholder = [NSAttributedString.Key.foregroundColor=UIColor.FlatBlack()]
        
               let animatedGradient = AnimatedGradientView(frame: view.bounds)
               animatedGradient.direction = .up
               animatedGradient.animationValues = [(colors: ["#2BC0E4", "#F7D80F"], .up, .axial),
        //                                        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial)]
        //     (colors: ["#003973", "#E5E5BE"], .down, .axial)]
              (colors: ["#f5e76e", "#f7d04d", "#fcb03d"], .left, .axial)]
                animateView.addSubview(animatedGradient)
        
        visualBlur.alpha = 0
        
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
             navigationController?.navigationBar.isHidden = true
        }
    
    override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(false)
            navigationController?.navigationBar.isHidden = false
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.bool(forKey: "userSignedIn") {
             performSegue(withIdentifier: "goToHomeVC", sender: self)
        }
    }
    
  
    
    @IBAction func loginPressed(_ sender: UIButton) {
        sender.pulsate()
        
        let email = emailIdTF.text
        
        
        signinUser(email: emailIdTF.text!, password: passwordTF.text!)
    }

    @IBAction func forgotPaaswordPressed(_ sender: UIButton) {
        
    
       
        
        visualBlur.alpha = 1
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#F7D80F"], .up, .axial),
                
        (colors: ["#f5e76e", "#f7d04d", "#fcb03d"], .left, .axial)]
        animatedViewOnBlur.addSubview(animatedGradient)
        
        
    
        
    }
    


 
    

    func signinUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email , password: password) { ( user, error) in
            if error == nil{
                

                
                self.performSegue(withIdentifier: "goToHomeVC", sender: self)
                
                print("User signed in")
                self.userDefaults.set(true, forKey:"userSignedIn")
                self.userDefaults.synchronize()
            
                
                
            }else if(error?._code == AuthErrorCode.userNotFound.rawValue){
               
            }else {
                print(error)
                print(error?.localizedDescription)
            }
        }
    
    }
    @IBAction func backPressed(_ sender: UIButton) {
        visualBlur.alpha = 0
    }
    
    @IBAction func setPressed(_ sender: UIButton) {
        


        guard let emailId = emailTF.text else {return}
        
        Auth.auth().sendPasswordReset(withEmail: emailId) { (error) in
            if error != nil{
                print(error)
            }
        }
        
        let alert = UIAlertController(title: "Reset Link Send", message: "Password Reset link is send to your Email. Please check your email & reset your password.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            self.visualBlur.alpha = 0
        }))
        present(alert, animated: true)

        }
        
    }

