//
//  DetailViewController.swift
//  homework3_Basic
//
//  Created by Mac on 2016. 1. 18..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var urlString :String?
    
    @IBOutlet weak var detailImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //print(urlString)
        
        let checkedUrlString = urlString!.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        //print(checkedUrlString)
        if let checkedUrl = NSURL(string: checkedUrlString ){
            detailImageView.contentMode = .ScaleAspectFit
            getDataFromUrl(checkedUrl) { (data, response, error)  in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    guard let data = data where error == nil else { return }
                    //print("Download Finished")
                    self.detailImageView.image =  UIImage(data: data)
                }
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
}
