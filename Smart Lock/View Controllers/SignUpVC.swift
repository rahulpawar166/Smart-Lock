//
//  SignUpVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 11/06/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var contactNumberTF: UITextField!
    @IBOutlet weak var membersInFamilyTF: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == nameTF{
              emailTF.becomeFirstResponder()
          }else if textField == emailTF{
              passwordTF.becomeFirstResponder()
          }else if textField == passwordTF{
              confirmPasswordTF.becomeFirstResponder()
          }else if textField == confirmPasswordTF{
              addressTF.becomeFirstResponder()
          }else if textField == addressTF{
              contactNumberTF.becomeFirstResponder()
          }else if textField == contactNumberTF{
              membersInFamilyTF.becomeFirstResponder()
          }else {
              membersInFamilyTF.resignFirstResponder()
          }
          
          return true
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                      NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // Move View Up with Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 200
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
   
    

    @IBAction func signInPressed(_ sender: UIButton) {
        
        guard let name = nameTF.text, let emailId = emailTF.text, let password = passwordTF.text, let confirmPassword = confirmPasswordTF.text, let address = addressTF.text, let contactNumber =  contactNumberTF.text, let membersInFamily = membersInFamilyTF.text else {return}
        
        if (name == "" && emailId == "" && password == "" && confirmPassword == "" && address == "" && contactNumber == "" && membersInFamily == "") {
            let alert = UIAlertController(title: "Something Went Wrong", message: "Make Sure all the fields are filled properly.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            
           
         
        }else if password != confirmPassword {
            let alert = UIAlertController(title: "Password do not match", message: "Confirm the password & try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
        } else{
            print("Successful")
            
            UserDefaults.standard.set(emailId, forKey: "savedUserName")
            
            Auth.auth().createUser(withEmail: emailId, password: confirmPassword) { (result, error) in
                if error == nil{
                    print("User created successfull")
                    
                    let uid =  Auth.auth().currentUser?.uid as! String
                    let ref = Database.database().reference(fromURL: "https://smart-lock-754cc.firebaseio.com/")
                    let userRef = ref.child("Users").child(uid)
                    let values = ["Name": name, "Email ID": emailId, "Address": address, "Contact Number": contactNumber, "Members In Family": membersInFamily]
                    userRef.updateChildValues(values){(err, ref) in
                        if err != nil{
                            print(err)
                        }else {
                            print("Successfully registered User")
                            
                            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                            self.show(loginVC, sender: self)
                            
                            
                            }
                        }
                    
                }else{
                    print("Error while user creation in,\(error?.localizedDescription)")
                    let alert = UIAlertController(title: "Error", message: "Email ID is already registered.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                }
            }
                   
        }
      
        
    }
    
    }
    

