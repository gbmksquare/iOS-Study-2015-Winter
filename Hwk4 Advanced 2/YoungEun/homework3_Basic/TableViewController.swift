//
//  TableViewController.swift
//  homework3_Basic
//
//  Created by Mac on 2016. 1. 18..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TableViewController: UITableViewController {

    
    struct Photo {
        var id : Int
        var title : String
        var thumbnailUrl : String
        var url : String
        
    }
    var myPhoto = [Photo]()
    
    let networkActivityManager = NetworkActivityManager()
    var count = 0;
    
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        
        title = "이거슨 제목"  // 네비게이션 에서 타이틀
        
        setUpTableView()
        loadinitialPhotos()
       
    }
   
    func  requestAndResponseHandling(cellNum : Int){
        let postEndpoint: String = "http://jsonplaceholder.typicode.com/photos/\(cellNum)"
        
        //Countf
        self.networkActivityManager.increaseNetworkCount()
        
        
        Alamofire.request(.GET, postEndpoint)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print("error calling GET on /photos/\(cellNum)")
                    print(response.result.error!)
                    self.networkActivityManager.decreaseNetworkCount()
                    return
                }
                
                if let value: AnyObject = response.result.value {
                    let post = JSON(value)
                    
                    let tmpPhoto = Photo(
                        id : post["id"].int!,
                        title: post["title"].string!,
                        thumbnailUrl: post["thumbnailUrl"].string!,
                        url: post["url"].string!)
                    
                    self.myPhoto.append(tmpPhoto)
                  
                    let indexPaths = [NSIndexPath(forRow: self.myPhoto.count-1, inSection: 0)]
                    self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
                    
                    self.networkActivityManager.decreaseNetworkCount()
                }
        }
    }
    
    func setUpTableView(){
        tableView.dataSource = self
        tableView.delegate = self // 액션 일어났을때
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "이거슨 섹션 \(section+1)"
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return myPhoto.count
            
        default :
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell")! as! TableViewCell
        cell.identifier = myPhoto[indexPath.row].thumbnailUrl
        cell.populateCell(myPhoto[indexPath.row].thumbnailUrl)
        cell.titleLabel.text = myPhoto[indexPath.row].title
        return cell
    }
    
    
    
    
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        if networkActivityManager.networkCount == 0 && (maximumOffset - contentOffset < -60 ){
            loadMorePhotos()
        }
    }
    
    
    
    func loadinitialPhotos(){
        print("initially getting photos")
        let start = 1
        let end = 11
        for i in start..<end {
            requestAndResponseHandling(i)
        }
    }
    func loadMorePhotos(){
        print("loading more photos")
        let start = myPhoto.count + 1
        let end = myPhoto.count + 6
        for i in start..<end {
            requestAndResponseHandling(i)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case "mySegue" :
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.urlString = myPhoto[tableView.indexPathForSelectedRow!.row].url
        default: return
        }
    }

    
    
}
class NetworkActivityManager {
    var networkCount: Int = 0 {
        willSet(newValue) {
            if newValue > 0 {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            } else {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        didSet {
        }
    }
    
    func increaseNetworkCount() {
        networkCount++
    }
    func decreaseNetworkCount(){
        networkCount--
    }
}