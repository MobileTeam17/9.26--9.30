//
//  addNewBill.swift
//  BoWang
//
//  Created by 王博 on 23/9/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import Foundation







// ----------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// ----------------------------------------------------------------------------
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import UIKit

protocol ToDoItemDelegate {
    func didSaveItem(_ label: String, _ theCost: String, _ describ: String)
}

class addNewBill: UIViewController,  UIBarPositioningDelegate, UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var labels: UITextField!
    
    
    @IBOutlet weak var theCost: UITextField!
    
    
    @IBOutlet weak var describ: UITextField!
    
    
    @IBOutlet weak var picture: UITextField!

    
    @IBOutlet weak var freeOne: UITextField!
    

    
    var delegate : ToDoItemDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //self.labels.delegate = self
        //self.labels.becomeFirstResponder()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.labels.resignFirstResponder()
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        let labels = self.labels.text
        let theCost = self.theCost.text
        let describ = self.describ.text
        let picture = self.picture.text
        
        if (labels?.isEmpty)! || (theCost?.isEmpty)! || (describ?.isEmpty)! || (picture?.isEmpty)! {
            
            //display an alert message
            
            displayMyAlertMessage(userMessage: "all filed are required")
            
            return
        }
        
        //check if password match
        
        if (Int(theCost!) == nil) {
            
            //display an alert message
            
            displayMyAlertMessage(userMessage: "The cost should be number")
            
            return
        }
            
        else{
            

            
            saveItem()
            self.labels.resignFirstResponder()
            //self.dismiss(animated: true, completion: nil)

            
            //display alert message with confimation
            
            let myAlert = UIAlertController(title:"Saved", message: "you add the bill successfully, thank you", preferredStyle: UIAlertControllerStyle.alert)
            
            self.present( myAlert, animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                //myAlert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
                
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                myAlert.dismiss(animated: true, completion: nil)
                
            }
            

        }
    }
    
    
    // Textfield
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        saveItem()
        
        textField.resignFirstResponder()
        return true
    }
    
    func displayMyAlertMessage(userMessage: String)  {
        let myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    // Delegate
    
    func saveItem()
    {
        //let theCost = self.theCost.text
        //let describ = self.describ.text
        if let theCost = self.theCost.text,
            let labels = self.labels.text,
            let describ = self.describ.text
        {
            self.delegate?.didSaveItem(labels,theCost,describ)
            
        }
    }
}
