//
//  FirstViewController.swift
//  CHaRM
//
//  Created by Pranay Kumar on 1/10/19.
//  Copyright © 2019 JID8306. All rights reserved.
//
import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var Scroller: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        map.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        map.layer.borderWidth = 1
    }
    
    override func viewDidLayoutSubviews() {
        Scroller.isScrollEnabled = true
        Scroller.contentSize = CGSize(width: 400,height: 2300)
    }
    @IBOutlet weak var map: UIImageView!

}

