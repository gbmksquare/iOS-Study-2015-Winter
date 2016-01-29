//
//  ViewController.swift
//  study2
//
//  Created by Pak Suzi on 2016. 1. 14..
//  Copyright © 2016년 suzipak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var PickButton: UIButton!
    
    @IBAction func clickPickButton(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            imagePicker.sourceType = .PhotoLibrary

            self.presentViewController(imagePicker, animated: true, completion: nil)
    
        } else {
            // 사진라이브러리 사용 불가능
            cannotAccessPhotoLibrary()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap1 = UITapGestureRecognizer(target: self, action: "tapImage1")
        let tap2 = UITapGestureRecognizer(target: self, action: "tapImage2")
        
        image1.addGestureRecognizer(tap1)
        image2.addGestureRecognizer(tap2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func cannotAccessPhotoLibrary() {
        let alertController = UIAlertController(title: "사진 접근 불가능", message: "설정에서 변경하세요", preferredStyle: .Alert)
        let confirm = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default) {(_) -> Void in
            
        }
        alertController.addAction(confirm)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [NSObject : AnyObject]?) {
        if (image1.image == nil) && (image2.image != nil) {
            image2.image = image
        }
        else {
            image1.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapImage1() {
        if image1.image != nil {
            image2.image = image1.image
            image1.image = nil
        }
    }
    
    func tapImage2() {
        if image2.image != nil {
            image1.image = image2.image
            image2.image = nil
        }
    }
    
}
