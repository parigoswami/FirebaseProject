//
//  myTableViewController.swift
//  FirebaseProject
//
//  Created by pari on 07/08/17.
//  Copyright © 2017 pari. All rights reserved.
//

import UIKit
import CoreData

class myTableViewController: UITableViewController {
    
    var tempStr : String = ""
    var datax = [Tasks]()
    var tempArr = [NSManagedObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action:#selector(myTableViewController.addFunc))
        print("Hello")
    }

    func addFunc(){
        let alert = UIAlertController(title: "AlertController", message: "Whatever Your Message is here", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {
            (action) -> Void in
            let textfield = alert.textFields![0]
            print("Text Text is ",textfield.text!)
            self.tempStr=textfield.text!
            print(self.tempStr)
            let taskX = Tasks(context: context)
            taskX.mydata = self.tempStr
            appDelegate.saveContext()
            self.fetchData()
            self.tableView.reloadData()
            
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            (action) -> Void in
        })
        
        
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Type something here"
            textField.clearButtonMode = .whileEditing
            
        }
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }

    func fetchData(){
        do {
            datax=try context.fetch(Tasks.fetchRequest())
            for each in datax as [NSManagedObject]{
                                print("Data is ",each.value(forKey: "mydata")!)
                self.tempArr.append(each)
            }
        } catch
        {
        }
//        print("DONE FETCH>>>>>>>")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseIdentifier", for: indexPath)
        cell.textLabel?.text=tempArr[indexPath.row].value(forKey: "mydata") as? String
        // Configure the cell...

        return cell
    }
 
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
             context.delete(tempArr[indexPath.row])
            do {
                try context.save()
                self.tempArr.removeAll(keepingCapacity: true)
                self.fetchData()
                self.tableView.reloadData()
            } catch  {
                
            }
            

//
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
