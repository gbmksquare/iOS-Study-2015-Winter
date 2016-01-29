//
//  MainTableViewController.swift
//  gaje3
//
//  Created by SonChang Woo on 2016. 1. 20..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTableViewController: UITableViewController {

    var datas: [JSON] = []
    
    let networkManger = NetworkActivitiyManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            // Network
            self.get()
        }
        title = "gaje3"
    }
    
    private func setData() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        
        let data = self.datas[indexPath.row]
        cell.textLabel?.text = "\(data["id"])"
        
        let replaceString = data["thumbnailUrl"].string?.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        
        if let url = NSURL(string: replaceString!) {
            if let data = NSData(contentsOfURL: url) {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    

    func get() {
        let urlinput = "http://jsonplaceholder.typicode.com/photos"
        self.networkManger.increaseNetworkCount()
        Alamofire.request(.GET, urlinput).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    if let data = json.arrayValue as? [JSON] {
                        self.datas = data
                        self.tableView.reloadData()
                        self.networkManger.decreaseNetworkCount()
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let _ = segue.identifier else {
                return
        }
        let data = datas[tableView.indexPathForSelectedRow!.row]
        let identifier = segue.identifier!
        
        switch identifier {
        case "passImage":
                let imageViewController = segue.destinationViewController as! ImageViewController
                imageViewController.url = data["url"].string
        default: return
            
        }
        
    }
}

class NetworkActivitiyManager {
    var networkCount = 0 {
        willSet {
            if newValue > 0 {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
            else {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        didSet {
            
        }
    }
    
    func increaseNetworkCount() {
        networkCount++
    }
    func decreaseNetworkCount() {
        networkCount--
    }
}

