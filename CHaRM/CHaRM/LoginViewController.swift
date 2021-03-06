//
//  LoginViewController.swift
//  CHaRM
//
//  Created by Pranay Kumar on 1/12/19.
//  Copyright © 2019 JID8306. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var segueShouldOccur = true || false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.layer.borderColor = UIColor.gray.cgColor
        password.layer.borderColor = UIColor.gray.cgColor
        email.layer.borderWidth = 1.0
        password.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                print("There is no error")
                self.performSegue(withIdentifier: "loginToHome", sender: self)
                //self.segueShouldOccur = true
                //self.signIn()
            }
            else{
                //self.segueShouldOccur = false
                print("this is false")
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
   
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "loginToHome" {
//            print ("At verification")
//            print ("should occur: ", segueShouldOccur)
//            if !segueShouldOccur {
//                return false
//            } else {
//                return true
//            }
//        }
//        return true
//    }
//
//    func signIn() {
//        self.performSegue(withIdentifier: "loginToHome", sender: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
