//
//  MainVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 09/04/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseAuth
import AnimatedGradientView

class MainVC: UIViewController {

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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logineTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToLoginVC", sender: self)
    }
    
    @IBAction func phoneLoginTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToPhoneLoginVC", sender: self)
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
