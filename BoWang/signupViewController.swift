//
//  signupViewController.swift
//  BoWang
//
//  Created by zhe on 2017/9/21.
//  Copyright © 2017年 Microsoft. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var repeatPasswordText: UITextField!
    
    var itemTable = (UIApplication.shared.delegate as! AppDelegate).client.table(withName: "login")
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    var dicClient = [String:Any]()
    var dicClient2 = [String:Any]()
    var list = NSMutableArray()
    var list2 = NSMutableArray()
    var array:[AnyObject] = []
    var array2:[AnyObject] = []
    
    @IBAction func signupButton(_ sender: Any)
    {
        
        let userEmail = emailText.text
        let userPassword = passwordText.text
        let userRepeatPassword = repeatPasswordText.text
        
        //check empty
        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)! {
            
            //display an alert message
            
            displayMyAlertMessage(userMessage: "all filed are required")
            
            return
        }
        
        
        //check if password match
        
        if (userPassword != userRepeatPassword) {
            
            //display an alert message
            
            displayMyAlertMessage(userMessage: "Passwords do not match")
            
            return
        }
        
        
        //store data
        
        UserDefaults.standard.set(userEmail, forKey: "userRegistEmail")
        UserDefaults.standard.set(userPassword, forKey: "userRegistPassword")
        UserDefaults.standard.synchronize()
        
        
        //print("bbbbbbbbbbbbb: ", self.list)
        self.dicClient["email"] = userEmail
        self.dicClient["password"] = userPassword
        self.dicClient2["email"] = userEmail

        array.append(dicClient as AnyObject)
        array2.append(dicClient2 as AnyObject)
        
        UserDefaults.standard.set(array, forKey: "theUserData")
        UserDefaults.standard.set(array2, forKey: "theEmailData")
        
        
        
        let itemToInsert = ["email": userEmail, "password": userPassword] as [String : Any]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        self.itemTable.insert(itemToInsert) {
            
            (item, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error != nil {
                print("Error: " + (error! as NSError).description)
            }
        }
        
        
        //display alert message with confimation
        
        let myAlert = UIAlertController(title:"Alert", message: "registration is successful, thank you", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){
            action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present( myAlert, animated: true, completion: nil)

    }
    
    func displayMyAlertMessage(userMessage: String)  {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
        
 

    override func viewDidLoad() {
        super.viewDidLoad()
        array =  (UserDefaults.standard.array(forKey: "theUserData")) as! [AnyObject]
        print("aaaaaaaaaaa: ", UserDefaults.standard.array(forKey: "theUserData"))
        print("bbbbbbbbbbbbb: ", UserDefaults.standard.array(forKey: "theEmailData"))
        array2 = UserDefaults.standard.array(forKey: "theEmailData") as! [AnyObject]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
