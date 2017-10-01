//
//  shareBookId.swift
//  BoWang
//
//  Created by 王博 on 24/9/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import Foundation





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


class shareBookId: UIViewController,  UIBarPositioningDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    var bookId = ""
    var loginName = UserDefaults.standard.string(forKey: "userRegistEmail")
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "selectedBookId") != nil{
            bookId = UserDefaults.standard.string(forKey: "selectedBookId")!
        }
        else{
            if UserDefaults.standard.string(forKey: loginName!) != nil{
                bookId = UserDefaults.standard.string(forKey: loginName!)!
            }
        }
        
        label.text = "  The account book id is:    \(bookId) "
        
    }
    
    
    
    @IBAction func cancelPressed(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
