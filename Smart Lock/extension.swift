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
