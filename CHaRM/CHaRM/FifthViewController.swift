//
//  FifthViewController.swift
//  CHaRM
//
//  Created by Pranay Kumar on 1/10/19.
//  Copyright © 2019 JID8306. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {

    @IBOutlet weak var paintLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Profile: ", paintIndv)
        //let paintNum = UserDefaults.standard.value(forKey: "paintKey")
        for (mats, _) in myDict {
            print(mats)
            let temp = UserDefaults.standard.integer(forKey: mats)
//            if (temp != 0 ) {
//
//            }
            print("Material and Number: ", mats, temp)
            
        }
        
        //paintLabel.text =  String(paintNum)
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
