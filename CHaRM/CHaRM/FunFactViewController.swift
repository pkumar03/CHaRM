//
//  FunFactViewController.swift
//  CHaRM
//
//  Created by Pranay Kumar on 1/10/19.
//  Copyright © 2019 JID8306. All rights reserved.
//

import UIKit

class FunFactViewController: UIViewController {
    
    @IBOutlet weak var funFactLabel: UILabel!
    
    let funFactArray = ["1st Fact", "2nd Fact", "3rd Fact", "4th Fact", "5th Fact"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        funFactLabel.text = "0th Fact"
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        let j = Int.random(in: 0...funFactArray.count - 1)
        funFactLabel.text = funFactArray[j]
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
