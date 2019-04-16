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
    
    let funFactArray = ["Every hour, Americans throw away 2,500,000 plastic bottles!", "The average person could recycle over 25,000 cans throughout their lifetime if he or she recycled consistently!", "Recycling a 3-foot stack of newspapers can save one tree!", "It can take over 500 years for plastic to decompose in our landfills!", "For multiple materials, such as tin cans, recycling conserves up to 95% of the fresh water used in our mining and manufacturing processes!", "Recycling generates $200 billion in the U.S. economy annually!", "The EPA estimates that 75% of the American waste stream is recyclable, but we only recycle about 30% of it!", "The average person generates over 4 pounds of trash every day and about 1.5 tons of solid waste per year!", "In 2009, Americans threw away almost 9 million tons of glass. That could fill enough tractor trailers to stretch from NYC to LA (and back!)", "Americans throw away about 28 billion bottles and jars every year!", "The EPA estimates that 75% of the American waste stream is recyclable, but we only recycle about 30% of it!", "Every day American businesses generate enough paper to circle the earth 20 times!", "Paper products make up the largest part (approximately 40 percent) of our trash!", "Making recycled paper instead of new paper uses 64 percent LESS energy and uses 58 percent LESS water!"] //need to add some fun facts

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        funFactLabel.text = "Since opening 4 years ago, CHaRM has collected enough household hazardous material to fill 40 Olympic size pools!"
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
