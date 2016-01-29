//
//  ViewController.swift
//  HomeworkJH
//
//  Created by pyh on 2016. 1. 12..
//  Copyright © 2016년 pyh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate{

    @IBOutlet weak var myImage: UIImageView!
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.image = UIImage(named: "day")
    }
    
    // MARK: Action
//    button1 
//    using UIAlertController
//    function : change image and hide image
    @IBAction func button1(sender: UIButton) {
        alertControl()
    }
    
//    button2
//    using UIAlertView
//    function : change image and hide image
    @IBAction func button2(sender: UIButton) {
        showAlertView()
    }
    
    private func alertControl(){
        let alertController = UIAlertController(title: "Image", message: nil, preferredStyle: .Alert)

//         make function : change image and hide image
        let changeImage = UIAlertAction(title: "change", style: .Default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.changeImage()
        })
        
        let hideImage = UIAlertAction(title: "hide", style: .Default, handler: { [unowned self] (alert: UIAlertAction!) in
            self.myImage.hidden = !self.myImage.hidden
        })

//        add action in alertController
        alertController.addAction(changeImage)
        alertController.addAction(hideImage)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func showAlertView(){
        let alertViewer = UIAlertView(title: "image", message: "", delegate: self, cancelButtonTitle: "Change", otherButtonTitles: "Hide")
        
        alertViewer.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex{
        case 0:
            self.changeImage()
        case 1:
            myImage.hidden = !myImage.hidden
        default:
            break
        }
    }

    
    func changeImage(){
//        make image array and change images
        var changedImages = [UIImage(named: "day")!, UIImage(named: "night")!]
        
        if(myImage.image == changedImages[0]){
            myImage.image = changedImages[1]
        }
        else if (myImage.image == changedImages[1]){
            myImage.image = changedImages[0]
        }
    }
}

