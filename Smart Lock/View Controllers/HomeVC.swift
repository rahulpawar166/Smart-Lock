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
import AVFoundation
import FirebaseDatabase

class HomeVC: UIViewController, AVAudioPlayerDelegate {


    
    let userDefaults = UserDefaults.standard
    
    var audioPlayer : AVAudioPlayer!
    
    let currentDate = Date()
    let formatter = DateFormatter()
    let currentTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(false, animated: false)
     
     
        
        
    }
  
    @IBAction func lockPressed(_ sender: UIButton) {
        sender.pulsate()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: currentDate)
        formatter.timeStyle = .medium
        let time = formatter.string(from: currentTime)
        
        lock(state: "Locked", Date: date, Time: time)
        
        let soundUrl = Bundle.main.url(forResource: "lock door", withExtension: "mp3")     // step 4
        
        do {                                                                            // step 5
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
        }
        catch {                                                                         //step 6
            print(error)
        }
        audioPlayer.play()
    }
    
    @IBAction func unlockPressed(_ sender: UIButton) {
        sender.pulsate()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: currentDate)
        formatter.timeStyle = .medium
        let time = formatter.string(from: currentTime)
        lock(state: "Unlocked", Date: date, Time: time)
        let soundUrl = Bundle.main.url(forResource: "unlock door", withExtension: "mp3")     // step 4
                      
                      do {                                                                            // step 5
                          audioPlayer = try AVAudioPlayer(contentsOf: soundUrl!)
                      }
                      catch {                                                                         //step 6
                          print(error)
                      }
                      audioPlayer.play()
    }
    
    func lock(state: String, Date: String, Time: String){
            
        let uid = Auth.auth().currentUser?.uid as! String
        
               formatter.dateFormat = "dd/MM/yyyy"
               let idDate = formatter.string(from: currentDate)
               let formattedDate = idDate.replacingOccurrences(of: "/", with: "")
               formatter.timeStyle = .medium
               let idTime = formatter.string(from: currentTime)
               
               let newTime = idTime.replacingOccurrences(of: ":", with: "")
               let againTime = newTime.replacingOccurrences(of: " ", with: "")
               let formattedTime = againTime.replacingOccurrences(of: "PM", with: "")
              
               
               let id = formattedDate+formattedTime+state
        
        
        
        
        
        let ref = Database.database().reference()
        
        let values = ["state": state, "Date": Date, "Time": Time, "ID": id]
        ref.child("Users").child(uid).child("Smart Lock").updateChildValues(values)
        ref.child("Users").child(uid).child("History").childByAutoId().updateChildValues(values)
        ref.keepSynced(true)
    }
    
 
    
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        do{
                      try Auth.auth().signOut()
                      userDefaults.removeObject(forKey: "userSignedIn")
                      userDefaults.synchronize()
            
                    print("User Signed Out")

            let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
            self.show(loginVC, sender: self)

                  
                      
              }   catch let error as NSError{
                      print(error.localizedDescription)
                  }
    }

}
