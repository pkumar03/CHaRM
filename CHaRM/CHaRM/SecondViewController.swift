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
        showSafariVC(for: "https://www.paypal.com/donate/?token=gu_ENMnbElN5hZ2eWQeAgtjcaKatUHbA_bpGSBgz1ptShHN7St4EoZuS93Fr5x5pZI4QhW&country.x=US&locale.x=US")
        
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

