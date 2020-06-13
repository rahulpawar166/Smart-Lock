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
        // Do any additional setup after loading the view.
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
