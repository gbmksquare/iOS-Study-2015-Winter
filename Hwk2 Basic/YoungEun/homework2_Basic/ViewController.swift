//
//  ViewController.swift
//  homework2_Basic
//
//  Created by Mac on 2016. 1. 11..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    private var imageView : [UIImageView] = []
    private var currImageViewNum = 0
    private var isFirstLaunch = true
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        setUI()


       
    }

    func setUI(){
        
        imageView.append(imageView1)
        imageView.append(imageView2)
        
        
        imageView[0].backgroundColor = UIColor.lightGrayColor()
        imageView[1].backgroundColor = UIColor.lightGrayColor()
       
        
        
        
    }
    
    
    private func addNewImage() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let imageTmp = image
        
        
        
        imageView[currImageViewNum].image = imageTmp
        currImageViewNum = 1-currImageViewNum
        imageView[currImageViewNum].image = nil
        
        
        
        dismissViewControllerAnimated(true , completion: nil)
        
    }

    //MARK:- PHOTO LIBRARY ACCESS CHECK
    func photoLibraryAccessibilityCheck()
    {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.Authorized
        {
            addNewImage()
        }
        else
        {
            alertToEncouragePhotoLibraryAccess()
        }
    }
    
    //dispatch_async(dispatch_get_main_queue(), {})
    private func alertToEncouragePhotoLibraryAccess()
    {
        //Photo Library not available - Alert
        let cameraUnavailableAlertController = UIAlertController (title: "포토 라이브러리 접근 제한", message: "설정에서 변경하세요", preferredStyle: .Alert)
        
        let settingsAction = UIAlertAction(title: "설정", style: .Destructive) { (_) -> Void in
            let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().openURL(url)
                })
                
                
            }
        }
        let cancelAction = UIAlertAction(title: "확인", style: .Default, handler: nil)
        cameraUnavailableAlertController .addAction(settingsAction)
        cameraUnavailableAlertController .addAction(cancelAction)
        presentViewController(cameraUnavailableAlertController , animated: true, completion: nil)
        
    }
    
    @IBAction func tappedButton(sender: AnyObject) {
        if isFirstLaunch {
            isFirstLaunch = false
            addNewImage()
        }
        else {
            photoLibraryAccessibilityCheck()
        }
        
    }
   
}
