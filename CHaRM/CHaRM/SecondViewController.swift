//
//  SecondViewController.swift
//  CHaRM
//
//  Created by Pranay Kumar on 1/10/19.
//  Copyright © 2019 JID8306. All rights reserved.
//

import UIKit
import SafariServices

class SecondViewController: UIViewController {

    @IBAction func payPalPressed(_ sender: Any) {
        showSafariVC(for: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=77CFF58BGD5T4&source=url")
        
    }
    
    func showSafariVC(for url:String) {
        guard let url = URL(string: url) else {
            //show an invaild URL error alert
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

