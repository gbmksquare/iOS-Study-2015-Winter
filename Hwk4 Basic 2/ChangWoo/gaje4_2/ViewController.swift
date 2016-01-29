//
//  ViewController.swift
//  gaje4_2
//
//  Created by SonChang Woo on 2016. 1. 24..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cells = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    private func setData() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "cell \(indexPath.row+1)"
        return cell
    }
    
    // edit tableview cell
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) -> Void in
            // Do something
            self.cells.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.setEditing(false, animated: true)
        }
        
        let action2  = UITableViewRowAction(style: .Normal, title: "Insert") { (action, indexPath) -> Void in
            //Do something
            self.cells.insert("\(indexPath.row)", atIndex: indexPath.row+1)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Bottom)
            
            tableView.setEditing(false, animated: true)
        }
        action2.backgroundColor = UIColor.blueColor()
        return [action, action2]
    }
    
    //reset
    @IBAction func tappedButton(sender: UIBarButtonItem) {
        self.cells = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        tableView.reloadData()
    }

}

