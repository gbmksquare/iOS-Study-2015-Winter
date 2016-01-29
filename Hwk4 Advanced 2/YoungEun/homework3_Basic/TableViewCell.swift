//
//  TableViewCell.swift
//  homework3_Basic
//
//  Created by Mac on 2016. 1. 20..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    var thumbnailUrl : String!
    var identifier : String!
    
    var myCache = SDImageCache (namespace: "MyUniqueCacheKey")

    
    var downloadedImage: UIImage!


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
    }
    
    func populateCell(url: String){
        let checkedUrlString = url.stringByReplacingOccurrencesOfString("http://", withString: "https://")
     
        myCache.queryDiskCacheForKey(url) { (image, SDImageCacheType) -> Void in
            if image != nil {
                print("already there")
                self.thumbnailImageView.image = image
            }
            else{
                print("downloading")
                if let checkedUrl = NSURL(string: checkedUrlString ){
                    self.getDataFromUrl(checkedUrl) { (data, response, error)  in
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            guard let data = data where error == nil else { return }
                            self.myCache.storeImage(UIImage(data: data), forKey: url)
                            if url == self.identifier {
                                self.thumbnailImageView.image =  UIImage(data: data)
                            }
                        }
                    }
                }
            }
        }//end myCache.query..
        
    }//end populateCell
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }

}
