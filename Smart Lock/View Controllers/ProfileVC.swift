//
//  ProfileVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 14/04/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
   
    @IBOutlet weak var contactNumberTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var membersInFamilyTF: UITextField!
    
    let uid = Auth.auth().currentUser?.uid as! String
    
    var profileImagePicker = UIImagePickerController()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
   
            if textField == nameTF{
                emailIDTF.becomeFirstResponder()
            } else if textField == emailIDTF{
                contactNumberTF.becomeFirstResponder()
            }else if textField == contactNumberTF{
                addressTF.becomeFirstResponder()
            }else if textField == addressTF{
                membersInFamilyTF.becomeFirstResponder()
            }else{
                membersInFamilyTF.resignFirstResponder()
            }
        return true
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
         profileImagePicker.delegate = self
               
                profileImage.layer.borderWidth = 1
                profileImage.layer.masksToBounds = false
                profileImage.layer.borderColor = UIColor.black.cgColor
                profileImage.layer.cornerRadius = profileImage.frame.height/2
                profileImage.clipsToBounds = true
        
        // Move View Up with Keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
       
        
//              let ref = Database.database().reference()
//                let userRef = ref.child("Users").child(uid)
//
//              userRef.observe(.childAdded) { (snapshot) in
//                  let snapshotValue = snapshot.value as! Dictionary<String,Any>
//
//                  let profileImageUrl = snapshotValue["Profile Image URL"]
//                  print(profileImageUrl)
//
//
              
        
       

        
    }
    override func viewWillAppear(_ animated: Bool) {
        //MARK: - Retriving saved image from UserDefaults
//
         if UserDefaults.standard.object(forKey: "savedImage") != nil{

                let data = UserDefaults.standard.object(forKey: "savedImage") as! NSData

               profileImage.image = UIImage(data: (data as Data))
               } else {
                   profileImage.image = UIImage(named: "profile")
               }
               
       

        
        nameTF.text = UserDefaults.standard.object(forKey: "savedName") as? String
        emailIDTF.text = UserDefaults.standard.object(forKey: "savedEmail") as? String
        contactNumberTF.text = UserDefaults.standard.object(forKey: "savedContactNumber") as? String
        addressTF.text = UserDefaults.standard.object(forKey: "savedAddress") as? String
        membersInFamilyTF.text = UserDefaults.standard.object(forKey: "savedMembersInFamily") as? String
        
    }
    // Move View Up with Keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 150
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
  

    
    @IBAction func setProfilePictureTapped(_ sender: UITapGestureRecognizer) {
        
        profileImagePicker.sourceType = .photoLibrary
        profileImagePicker.allowsEditing = true
        present(profileImagePicker, animated: true, completion: nil)
        
        
    }
    @IBAction func setPressed(_ sender: Any) {
        
        
        guard let name = nameTF.text, let email = emailIDTF.text, let contact = contactNumberTF.text, let address = addressTF.text, let membersInfamily = membersInFamilyTF.text else {return}
        
        let userEmail = Auth.auth().currentUser?.email as! String
        let uid = Auth.auth().currentUser?.uid as! String
        
        let storageRef = Storage.storage().reference(forURL: "gs://smart-lock-754cc.appspot.com").child("Users").child(userEmail)
        if let image = profileImage.image{
            let uploadData:  NSData = image.pngData()! as NSData
            storageRef.putData(uploadData as Data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }else{
                    print("Successfully profile image stored to firebase storage")
                }
                                            
                }
            storageRef.downloadURL { (url, error) in
                if error != nil{
                    print(error)
                }else{
                    let ref = Database.database().reference()
                    let imageUrl = url?.absoluteString
                    let userRef = ref.child("Users").child(uid)
                    let values = ["Name": name, "Email ID": email, "Address": address, "Contact Number": contact, "Members In Family": membersInfamily, "Profile Image URL": imageUrl]
                    userRef.updateChildValues(values){ (error, ref) in
                        if error != nil{
                            print(error)
                        }else{
                            print("Successfully update user profile")
                        }
                        
                    }
                   
                }
            }
            
            
        
        }
        
        
        
        
        
        
        
        
        //MARK: - Saving Profile Image
         let image = profileImage.image
         let savedImageData:  NSData = image?.pngData() as! NSData
        
         UserDefaults.standard.set(savedImageData, forKey: "savedImage")
     
        
        let alert = UIAlertController(title: "Profile Saved", message: "Your Profile is successfully updated & saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                  self.show(homeVC, sender: self)
        }))
        present(alert, animated: true)
        
      
         
    }
    


}

extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImage.image = image
            
           
            
            

            
            
        }
        dismiss(animated: true, completion: nil)
       
        
    }
}
