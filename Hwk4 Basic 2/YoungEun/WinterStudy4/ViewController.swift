//
//  ViewController.swift
//  WinterStudy4
//
//  Created by Mac on 2016. 1. 23..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit

//테이블뷰컨트롤러보다 이렇게 쓰는게 훨신 확장성이 높다
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshBarButton : UIBarButtonItem!
    var refreshControl = UIRefreshControl()
    var cnt = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setupRefreshControl()
    }

    private func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: "handleRefreshControl:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefreshControl(sender: UIRefreshControl){
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 3))
        let mainQueue = dispatch_get_main_queue()
        dispatch_after(time, mainQueue) {[weak self] () -> Void in
            self?.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func tappedRefreshButton(sender: AnyObject) {
        cnt = 10
        tableView.reloadData()
    }
    
    
    //MARK: Table view
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cnt
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row + 1)"
        return cell
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .Default, title: "Delete" ) {(action, indexPath)-> Void in
        //Do Something
            self.cnt--
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableView.setEditing(false, animated: true)
        }
        let action2 = UITableViewRowAction(style: .Normal, title: "Add Row" ) {(action, indexPath)-> Void in
        //Do Something
            let newIndexPath = NSIndexPath(forRow: indexPath.row + 1, inSection: 0)
            self.cnt++
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            
            tableView.setEditing(false, animated: true)
        }
        action2.backgroundColor = UIColor.blueColor()
        return [action, action2]
    }
    
    
}

