//
//  ViewController.swift
//  WinterStudy2_AutoLayout
//
//  Created by Mac on 2016. 1. 9..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = UIColor.lightGrayColor()
        
        addGestureRecognizer()
        // Do any additional setup after loading the view, typically from a nib.
    }

    private func addNewImage() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    private func addGestureRecognizer(){
        let gesture = UITapGestureRecognizer()
        // gesture.numberOfTapsRequired = 1 // 몇 번 누름?
        // gesture.numberOfTouchesRequired = 1 // 동시에 몇 손가락?
        gesture.addTarget(self, action: "handleGesture:") //함수 뒤에 콜론이 붙는 이유는 파라미터가 있기 때문
        imageView.addGestureRecognizer(gesture)
        imageView.userInteractionEnabled = true //이미지뷰만 디폴트가 폴스라서 해줘야함
    }
    
    @objc private func handleGesture(sender: UITapGestureRecognizer){
        addNewImage()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = image
        dismissViewControllerAnimated(true , completion: nil)
        
    }
    @IBAction func tappedButton(sender: AnyObject) {
        addNewImage()
    }
    
    

}

