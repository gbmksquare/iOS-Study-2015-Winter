//
//  ViewController.swift
//  Homework2
//
//  Created by pyh on 2016. 1. 15..
//  Copyright © 2016년 pyh. All rights reserved.
//

import UIKit
import Photos
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBAction func pickImageButton(sender: UIButton) {
        addNewImage()
    }

    private var showOnFirstImage = true
    
    private func gestureRecognizer() {
        let gesture = UITapGestureRecognizer()
        gesture.numberOfTapsRequired = 1
        gesture.addTarget(self, action: "handleTapGesture")
        
    }
    
    func handleTapGesture(sender:UITapGestureRecognizer) {
        addNewImage()
    }
    
    private func addNewImage(){
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true, completion: nil)

//  set image in order
        if showOnFirstImage == true {
            image1.image = image
            showOnFirstImage = !showOnFirstImage
        }
        else {
            image2.image = image
            showOnFirstImage = !showOnFirstImage
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        image1.backgroundColor = UIColor.grayColor()
        image2.backgroundColor = UIColor.grayColor()

//confirm permission of PhotoLaibrary
        PHPhotoLibrary.requestAuthorization {
            (PHAuthorizationStatus status) -> Void in
            switch (status){
            case .Authorized:
                self.gestureRecognizer()
            case .Denied:
                let deniedMessage = UIAlertController(title: "Permission denied", message: nil, preferredStyle: .Alert)
                self.presentViewController(deniedMessage, animated: true, completion: nil)
            default:
                let restrictedMessage = UIAlertController(title: "Permission restricted", message: nil, preferredStyle: .Alert)
                self.presentViewController(restrictedMessage, animated: true, completion: nil)
            }
        }
    }

}

