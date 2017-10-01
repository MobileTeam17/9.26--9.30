

//  accountBookList.swift


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
import CoreData



class userListPage: UITableViewController, ToDoItemDelegate2 {
    
    var table : MSSyncTable?
    var store : MSCoreDataStore?
    var list = NSMutableArray()
    var dicClient = [String:Any]()
    var refresh : UIRefreshControl!
    var theValue = ""
    var bookId = ""
    var loginName = UserDefaults.standard.string(forKey: "userRegistEmail")
    var owner = ""
    var itemTable = (UIApplication.shared.delegate as! AppDelegate).client.table(withName: "book_users")
    
    @IBOutlet weak var hello: UILabel!
    
    
    override func viewDidLoad() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let client2 = delegate.client
        itemTable = client2.table(withName: "book_users")
        if UserDefaults.standard.string(forKey: "selectedBookId") != nil{
            bookId = UserDefaults.standard.string(forKey: "selectedBookId")!
        }
        
        //hello.text = "  hello:  \(loginName!) !  welcome to the app"
        refresh = UIRefreshControl()
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        list = NSMutableArray()
        tableView.reloadData()
        
        tableView.dataSource=self
        tableView.delegate = self
        refresh.addTarget(self,action:#selector(billListAndDetail.refreshData(_:)), for: UIControlEvents.valueChanged)
        
        if UserDefaults.standard.string(forKey: "selectedBookId") != nil{
            UserDefaults.standard.set(bookId, forKey: "selectedBookId")
        }
        
        
        
        
        
        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        queue.sync {
            
            
        print("the initial list value is : ", list)
        itemTable.read { (result, error) in
             var ss = ""
            if let err = error {
                print("ERROR ", err)
            } else if let items = result?.items {
                print("the item list is : ", items.count)
                for item in items {
                    self.dicClient["id"] = "\(item["id"]!)"
                    self.dicClient["theUser"] = "\(item["theUser"]!)"
                    self.dicClient["bookId"] = "\(item["bookId"]!)"
                    
                    if "\(item["bookId"]!)" == self.bookId{
                        
                        
                        if !self.list.contains(self.dicClient){
                        
                        self.list.add(self.dicClient)
                        ss = "\(item["bookId"]!)"
                        
                        
                        print("the book is : ", ss)
                        print("the size is : ", self.list)
                        self.tableView.reloadData()

                        
                        print("1111111: ", self.list.count)
                    }
                    }
                    
                    self.tableView.reloadData()
                    self.tableView.reloadData()
                    self.refreshData(self.refresh)
                    self.refreshData(self.refresh)
                    
                }

            }
        }
        }
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        } else {
            tableView.addSubview(refresh)
        }
        
        
        self.refreshData(self.refreshControl)
        self.refreshData(self.refreshControl)
        self.refreshData(self.refreshControl)
        self.refreshData(self.refreshControl)
        print("the transfer bookId is : ", self.bookId)
    }
    
    func refreshData(_ sender: UIRefreshControl!){
        
        tableView.reloadData()
        //refresh.endRefreshing()
    }
    
    
    func showExample(_ segueId: String) {
        performSegue(withIdentifier: segueId, sender: nil)
    }
    
    
    func onRefresh(_ sender: UIRefreshControl!) {
        tableView.reloadData()
        
        refresh.endRefreshing()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Table Controls
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    {
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    {
        return "Complete"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("the number is : ", list.count)
        //self.tableView.reloadData()
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier = "Cell"
        
        //var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell = configureCell(cell, indexPath: indexPath)
        
        let client = self.list[indexPath.row] as! [String:String]
        
        cell.textLabel?.text =  client["theUser"] as! String
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        
        super.viewDidLoad()
        //self.tableView.reloadData()
        print("writing now : ", list.count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = self.list[indexPath.row] as! [String:String]
        
        theValue = client["theUser"] as! String
        
    }
    

    @IBAction func back(_ sender: UIBarButtonItem) {
        //self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(bookId, forKey: "selectedBookId")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addUser" {
            let todoController = segue.destination as! addNewUserToBook
            todoController.delegate = self
        }
        
    }
    
    
    
    @IBAction func home(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - ToDoItemDelegate
    
    
    func didSaveItem(_ theUser: String, _ bookId: String)
    {
        
        if theUser.isEmpty {
            return
        }
        if bookId.isEmpty {
            return
        }
        
        
        
        // We set created at to now, so it will sort as we expect it to post the push/pull
        let itemToInsert = ["theUser": theUser, "bookId": bookId, "__createdAt": Date()] as [String : Any]
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        self.itemTable.insert(itemToInsert) {
            
            (item, error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if error != nil {
                print("Error: " + (error! as NSError).description)
            }
        }
        
        self.dicClient["theUser"] = "\(itemToInsert["theUser"]!)"
        self.dicClient["bookId"] = "\(itemToInsert["bookId"]!)"
        self.dicClient["createdAt"] = "\(itemToInsert["__createdAt"]!)"

        
        self.list.add(self.dicClient)
        print("whether insert or not : ", list.count)
        print("the list is : ", self.list)
        //for index in 1...5 {
        
        
        
        //viewDidLoad()
        //viewDidLoad()
            
        //}
        
        
        Thread.sleep(forTimeInterval: 2)

        viewDidLoad()
        //tableView.reloadData()
        self.tableView.reloadData()
        //viewDidLoad()
    }
    
}






