//
//  ViewController.swift
//  gaje
//
//  Created by SonChang Woo on 2016. 1. 3..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
    }
    
    // MARK: Action
    @IBAction func tappedButton1(sender: UIButton) {
        showAlertController()
    }
    
    @IBAction func tappedButton2(sender: UIButton) {
        showAlertView()
    }
    
    // MARK: Alert
    func showAlertView() {
        let alertView = UIAlertView(title: "AlertView", message: "kkk", delegate: self, cancelButtonTitle: "changeImage", otherButtonTitles: "hideImage")
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        switch buttonIndex {
        case 0:
            if self.imageView.image == UIImage(named: "bag") {
                self.imageView.image = UIImage(named: "bag2")
            }
            else {
                self.imageView.image = UIImage(named: "bag")
            }
        case 1:
            self.imageView.hidden = !self.imageView.hidden
        default:
            break
        }
    }
    
    private func showAlertController() {
        let alertController = UIAlertController(title: "AlertController", message: "kkk", preferredStyle: .ActionSheet)
        
        let action1 = UIAlertAction(title: "changeImage", style: .Default)  { [unowned self] (_) -> Void in
            if self.imageView.image == UIImage(named: "bag") {
                self.imageView.image = UIImage(named: "bag2")
            }
            else {
                self.imageView.image = UIImage(named: "bag")
            }
        }

        let action2 = UIAlertAction(title: "hideImage", style: .Default) { [unowned self] (_) -> Void in
            if self.imageView.hidden == true{
                self.imageView.hidden = false
            }
            else {
                self.imageView.hidden = true
            }
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func setupImage() {
        let image = UIImage(named: "bag")
        imageView.image = image
    }
}

