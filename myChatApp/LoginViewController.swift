//
//  LoginViewController.swift
//  myChatApp
//
//  Created by Vijay Adhikari on 13/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit
import  Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTxt: UITextField!

    @IBOutlet weak var passwordTxt: UITextField!
    
    var IsLoginSuccess : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        FIRAuth.auth()?.signIn(withEmail: emailTxt.text!, password: passwordTxt.text!, completion: { (user, error) in
            SVProgressHUD.dismiss()

            if error != nil{
                print("error on login")
                self.IsLoginSuccess = false

            }else{
            
                print("login success")
                self.IsLoginSuccess = true
                self.performSegue(withIdentifier: "chatVC", sender: self)
            }
        })
    }

    

}
