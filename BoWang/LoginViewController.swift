//
//  LoginViewController.swift
//  BoWang
//
//  Created by zhe on 2017/9/21.
//  Copyright © 2017年 Microsoft. All rights reserved.
//


//test for uploader at github 
import Foundation
import UIKit
import Firebase
import FirebaseDatabase

protocol ToDoItemDelegate4 {
    func didSaveItem(_ theUser: String, _ bookId: String)
}

class LoginViewController: UIViewController,  UIBarPositioningDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var emailText: UITextField!
    

    
    @IBOutlet weak var passwordText: UITextField!

    
    
    var itemTable2 = (UIApplication.shared.delegate as! AppDelegate).client.table(withName: "book_users")
    
    var itemTable = (UIApplication.shared.delegate as! AppDelegate).client.table(withName: "login")
    var bookIdList = NSMutableArray()
        
    var loginName = ""
    var list = NSMutableArray()
    var list2 = NSMutableArray()
    var list3 = NSMutableArray()
    
    var dicClient = [String:Any]()
    var dicClient2 = [String:Any]()
    var dicClient3 = [String:Any]()
    override func viewDidLoad()
    {
        
        
        super.viewDidLoad()
        
        observeMessages()
        print("99999999999999999999999999")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let client = delegate.client
        itemTable = client.table(withName: "login")
        
        itemTable.read { (result, error) in
            if let err = error {
                print("ERROR ", err)
            } else if let items = result?.items {
                for item in items {
                    if !self.list.contains("\(item["email"]!)"){
                        self.list.add("\(item["email"]!)")
                    }
                    
                    self.dicClient["email"] = "\(item["email"]!)"
                    self.dicClient["password"] = "\(item["password"]!)"
                    
                    if !self.list2.contains(self.dicClient){
                        self.list2.add(self.dicClient)
                    }
                }
            }
        }
        UserDefaults.standard.set(list2, forKey: "theUserData")
        UserDefaults.standard.set(list, forKey: "theEmailData")
        print("ffffffffffff : ", list)
        print("nnnnnnnnnnnn : ", list2)
        
        
    }
    
    func observeMessages(){
        
        let ref = Database.database().reference().child("message")
        ref.observe(.childAdded, with: { (DataSnapshot) in
            

            
            let theMessage = "\(DataSnapshot.value!)" as? String
            var key = "\(DataSnapshot.key)" as? String
            self.dicClient3[key!] = theMessage

            print("bbggbgb", DataSnapshot.key)
            
            if key  == "text"{
                self.dicClient3["text"] = theMessage

            }
            if key  == "toId" {
                self.dicClient3["toId"] = theMessage
            }
            if key  == "fromId" {
                self.dicClient3["text"] = ""
            }
            if (self.dicClient3["text"] as? String == "" ||
                self.dicClient3["toId"] as? String == "" ||
                self.dicClient3["fromId"] as? String == "") {
                var dicClient3 = [String:Any]()
            }
            
        
            self.list3.add(self.dicClient3)
            
            print("bowang11111111", self.list3.lastObject)
            let fff = self.list3.lastObject as? [String:Any]
            if (fff?["text"] as? String != "" &&
                fff?["toId"] as? String != "" &&
                fff?["fromId"] as? String != "") {
                
                print("vfvfvfvfvfvfv", self.list3.lastObject )
                
                
                self.dicClient3["text"] = fff?["text"]
                self.dicClient3["toId"] = fff?["toId"]
                self.dicClient3["fromId"] = fff?["fromId"]
                self.list3.add(self.dicClient3)
                
                print("sxssssss", self.dicClient3["text"] as? String)
                
                UserDefaults.standard.set(self.dicClient3 , forKey: "Messages")
                print("rrrrrrr",UserDefaults.standard.array(forKey: "Messages"))
                
                
                UserDefaults.standard.set(self.dicClient3["text"] as? String, forKey: "theMessages")
                UserDefaults.standard.set(self.dicClient3["toId"] as? String, forKey: "receiveId")
            }
        })

    }
    
    
    
    func clearAllUserDefaultsData(){
        let userDefaults = UserDefaults.standard
        let dics = userDefaults.dictionaryRepresentation()
        for key in dics {
            userDefaults.removeObject(forKey: key.key)
        }
        userDefaults.synchronize()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let client = delegate.client
        itemTable = client.table(withName: "login")
        
        itemTable.read { (result, error) in
            if let err = error {
                print("ERROR ", err)
            } else if let items = result?.items {
                for item in items {
                    if !self.list.contains("\(item["email"]!)"){
                        self.list.add("\(item["email"]!)")
                    }
                    
                    self.dicClient["email"] = "\(item["email"]!)"
                    self.dicClient["password"] = "\(item["password"]!)"
                    
                    if !self.list2.contains(self.dicClient){
                        self.list2.add(self.dicClient)
                    }
                }
            }
        }
        UserDefaults.standard.set(list2, forKey: "theUserData")
        UserDefaults.standard.set(list, forKey: "theEmailData")
        
        
        observeMessages()
    }

    
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewDidLoad()
        self.setNeedsFocusUpdate()
        //if UserDefaults.standard.array(forKey: "theEmailData") != nil{
            //list = UserDefaults.standard.array(forKey: "theEmailData")! as! NSMutableArray
        //}
        //if UserDefaults.standard.array(forKey: "theUserData") != nil{
            //list2 = UserDefaults.standard.array(forKey: "theUserData")! as! NSMutableArray
        //}
        
        
        let userEmail = emailText.text
        let userPassword = passwordText.text
        
        //send 'email' and 'password' to server
        //here just read email and password
        self.dicClient["email"] = userEmail
        self.dicClient["password"] = userPassword
        print("the list isssssssss : ", list)
        print("the list2 isrrrrrrrrrrrrr : ", list2)
        if list.contains(userEmail){
            if list2.contains(dicClient){
                
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                
            }
            else{
                displayMyAlertMessage(userMessage: "Wrong Password!")
                
                return
            }
        }
        else {
            displayMyAlertMessage(userMessage: "The name does not exist!")
            
            return
        }
        
        UserDefaults.standard.set(userEmail, forKey: "userRegistEmail")

        
        UserDefaults.standard.set(self.dicClient3["text"] as? String, forKey: "theMessages")
        UserDefaults.standard.set(self.dicClient3["toId"] as? String, forKey: "receiveId")
        
        print("rffrfrrrfrfr",UserDefaults.standard.string(forKey: "theMessages"))
        
        performSegue(withIdentifier: "login", sender: nil)
        
    }
    

    func displayMyAlertMessage(userMessage: String)  {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
