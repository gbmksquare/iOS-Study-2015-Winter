//
//  ViewController.swift
//  homework1
//
//  Created by Mac on 2016. 1. 3..
//  Copyright © 2016년 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    let images: [UIImage] = [UIImage(named:"myDog1")!, UIImage(named:"myDog2")!,UIImage(named:"myDog3")!]
    var cur_num = 0;


    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //  showAlertController()
    }
    
    
    private func showAlertView(){
        let alertView = UIAlertView(title: "AlertView", message: "this is AlertView", delegate: self, cancelButtonTitle: "Next", otherButtonTitles: "Hide")
        
        // Configure Alert View
        alertView.tag = 1
        
        // Show Alert View
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1 {
            if buttonIndex == 0 {
                self.nextImage()
            } else {
                self.hideImage()
            }
        }
    }
    
    private func showAlertController(){
        let alertController = UIAlertController(title: "AlertController", message: "This is AlertController", preferredStyle: .Alert)
        let ActionNext = UIAlertAction(title: "Next", style: .Default){[weak self](_) -> Void in
        
            self?.nextImage()
        }
        let ActionHide = UIAlertAction(title: "Hide", style: .Default){[weak self](_) -> Void in
            
            self?.hideImage()
        }

        
        alertController.addAction(ActionNext)
        alertController.addAction(ActionHide)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    private func setupImage(){

        imageView.image = images[cur_num]    }
    
    @IBAction func tappedButton1(sender: UIButton){
        showAlertController()
       
    }
    @IBAction func tappedButton2(sender: UIButton){
        showAlertView()
    }
    
    private func nextImage(){
        imageView.image = images[++cur_num % images.count ]
    }
    private func hideImage(){
        if(imageView.hidden)
        {
            imageView.hidden = false;
        }
        else{
            imageView.hidden = true;
        }
    }

}

