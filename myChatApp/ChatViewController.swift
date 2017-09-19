//
//  ChatViewController.swift
//  myChatApp
//
//  Created by Vijay Adhikari on 13/09/2017.
//  Copyright © 2017 Vijay Adhikari. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource , UITextFieldDelegate{

    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var messageTxt: UITextField!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var messageArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTable.register(UINib(nibName:"customTableViewCell", bundle:nil), forCellReuseIdentifier: "customCell")
        
        configureTableView()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableTapped))
        messageTable.addGestureRecognizer(tapGesture)
        
        retriveMessages()

    }
    
    
    
    
    func retriveMessages(){
        
        let messageDB = FIRDatabase.database().reference().child("Messages")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as!  Dictionary<String, String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["sender"]!
            
            
            
            let message = Message()
            message.body = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTable.reloadData()
            })
    
    }
    
    func tableTapped(){
    messageTxt.endEditing(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customTableViewCell
     
        cell.messageLabel.text = messageArray[indexPath.row].body
        cell.senderNameLabel.text = messageArray[indexPath.row].sender
        cell.userImage.image = UIImage(named: "user.png")
        
        return cell
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 62
            self.view.layoutIfNeeded()
            
        }
        retriveMessages()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 320
            self.view.layoutIfNeeded()
        }
    }
    
    func configureTableView(){
    
        messageTable.rowHeight = UITableViewAutomaticDimension
        messageTable.estimatedRowHeight = 120.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendClicked(_ sender: UIButton) {
        
        messageTxt.endEditing(true)
        
        
        
        let messageDB = FIRDatabase.database().reference().child("Messages")

        let messageDic = ["sender" : FIRAuth.auth()?.currentUser?.email, "MessageBody" : messageTxt.text!]
        
        messageDB.childByAutoId().setValue(messageDic){ (error, ref) in
            
            if error != nil{
            print(error)
            }else{
            print("message saved")
            }
            
        
        }
    }

    @IBAction func logoutClicked(_ sender: UIBarButtonItem) {
        
        do{
            try FIRAuth.auth()?.signOut()
            
        }
        catch{
            print("error in sign out")
        }
        guard ((navigationController?.popToRootViewController(animated: true)) != nil) else {
            print("already in last VC")
            return
        }
        
        
    }
}
