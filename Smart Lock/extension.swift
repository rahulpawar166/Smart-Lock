//
//  extension.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 10/03/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}

//
//  var imagePicker = UIImagePickerController()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        imagePicker.delegate = self
//        hideKeyboardWhenTappedAround()
//
//        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
//        profilePicture.clipsToBounds = true
//        // Do any additional setup after loading the view.
//
//        errorLabel.alpha = 0
//    }
//
//
//    @IBAction func setProfilePicturePressed(_ sender: UIButton) {
//
//        imagePicker.sourceType = .photoLibrary
//
//         imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
//
//
//        //Upload Image to firebase storage
//      //  self.uploadProfileImage(<#T##image: UIImage##UIImage#>, completion: <#T##((String?) -> ())##((String?) -> ())##(String?) -> ()#>)
//        //Save profile picture to firebase database
//
//
//        //Dismiss the view
//    }
//
//
//
//        //check password & confirm password matche
//
//
//    func isPasswordValid(_ password : String) -> Bool {
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//
//        return passwordTest.evaluate(with: password)
//    }
//
//
//
//    @IBAction func signUpPressed(_ sender: UIButton) {
//
//    }
//
//    func showError (_ message:String){
//            errorLabel.text = message
//            errorLabel.alpha = 1
//    }
//
//
//
////    func createUser(email: String, password: String){
////
////
////         Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
////             if error == nil {
////                 print("User created successfull")
////                 //Sign in
////                 self.signinUser(email: email, password: password)
////             }else {
////                 print("Error while user creation in,\(error?.localizedDescription)")
////             }
////         }
////     }
//
//    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:String?)->())) {
//
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let storageRef = Storage.storage().reference().child("user/\(uid)")
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension signupVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
//            profilePicture.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//}
