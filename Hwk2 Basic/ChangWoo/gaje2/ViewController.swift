//
//  ViewController.swift
//  gaje2
//
//  Created by SonChang Woo on 2016. 1. 13..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    var checkNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    private func addNewImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .Denied {
            showAlertController()
        }
        else {
            presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if checkNum%2 == 0 {
            imageView1.image = image
            checkNum++
        }
        else {
            imageView2.image = image
            checkNum++
        }
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func tappedButton(sender: UIButton) {
        addNewImage()
    }
    
    func showAlertController() {
        let alertController = UIAlertController(title: "Title", message: nil, preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "No!!!", style: .Destructive, handler: nil)

        alertController.addAction(confirmAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    

}


