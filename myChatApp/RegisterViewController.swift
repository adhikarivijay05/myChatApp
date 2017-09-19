//
//  RegisterViewController.swift
//  myChatApp
//
//  Created by Vijay Adhikari on 13/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerClicked(_ sender: UIButton) {
        SVProgressHUD.show()
        
        FIRAuth.auth()?.createUser(withEmail: emailTxt.text!, password: passwordTxt.text!, completion: { (user, error) in
            SVProgressHUD.dismiss()

            if (error != nil){
                print(error!)
                
            }else{
            print("resgietr successful")
                self.performSegue(withIdentifier: "chatVC", sender: self)
            }
            
        })
        
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
