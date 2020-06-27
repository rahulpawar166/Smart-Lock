//
//  LiveFootageVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 12/04/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import WebKit

class LiveFootageVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: URL(string: "https://doggiest-puma-5684.dataplicity.io/")!))
   
    }


}
