//
//  SnapsViewControllerTableViewController.swift
//  Smapchat
//
//  Created by Dinesh  Gurnani on 11/11/17.
//  Copyright © 2017 Dinesh  Gurnani. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UITableViewController {

    var snaps : [DataSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        if let me = Auth.auth().currentUser?.uid {
            
            // Load snaps for ME
            Database.database().reference().child("users").child(me).child("snaps").observe(.childAdded, with: {(snapshot) in
                    self.snaps.append(snapshot)
                    self.tableView.reloadData()
                })
            
            // Delete snaps for ME
            Database.database().reference().child("users").child(me).child("snaps").observe(.childRemoved, with: {(snapshot) in
                
                var loopCounter = 0
                for element in self.snaps {
                    if(snapshot.key == element.key) {
                        // remove case
                        self.snaps.remove(at: loopCounter)
                    }
                    loopCounter += 1
                }

                self.tableView.reloadData()
                
            })
            
        }
        
        
        
    }

    @IBAction func Logout(_ sender: Any) {
        try! Auth.auth().signOut();
        dismiss(animated:true, completion: nil)
        print("Logout Success")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.snaps.count == 0 {
            // Case in which we shall put a placeholder cell with a message
            return 1
        } else {
            return self.snaps.count
        }
        
        
    }

    // Set the cells text
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            // Case in which we shall put a placeholder cell with a message
            cell.textLabel?.text = "No snaps yet 😢 ..."
        } else {
            let snap = snaps[indexPath.row]
        
            if let snapDic = snap.value as? NSDictionary {
                if let sender = snapDic["from"] as? String {
                    cell.textLabel?.text = sender
                } else {
                    cell.textLabel?.text = "Could not configure this"
                }
            }
        
        }
        
        return cell
    }
    
    // segue to the detailed snap view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "ViewSnapDetailSegue", sender: snap)
    }
    
    // pass the snap to the detailed view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewSnapDetailSegue" {
            if let controller = segue.destination as? DetailedSnapViewController {
                if let snap = sender as? DataSnapshot {
                    controller.snap = snap
                }
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
