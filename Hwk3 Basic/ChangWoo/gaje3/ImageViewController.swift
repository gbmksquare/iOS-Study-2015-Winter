//
//  ImageViewController.swift
//  gaje3
//
//  Created by SonChang Woo on 2016. 1. 20..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replaceString = url!.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        if let url = NSURL(string: replaceString) {
            if let data = NSData(contentsOfURL: url) {
                self.imageView.image = UIImage(data: data)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
        
//        if let checkedURL = NSURL(string: url!) {
//            downloadImage(checkedURL)
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        }
//        
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in completion(data: data, response: response, error: error)
        }.resume()
    }
    
    func downloadImage(url: NSURL) {
        getDataFromUrl(url) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let data = data where error == nil else { return }
                self.imageView.image = UIImage(data: data)
            })
        }
    }

}
