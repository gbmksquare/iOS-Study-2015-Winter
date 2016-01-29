//
//  ViewController.swift
//  study1
//
//  Created by Pak Suzi on 2016. 1. 2..
//  Copyright © 2016년 suzipak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1 : UIButton!
    @IBOutlet weak var button2 : UIButton!
    @IBOutlet weak var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //showAlertController()
        setupImage()
    }
    
    private func showAlertView() {
        let alertView = UIAlertView(title: "Title", message: nil, delegate: nil, cancelButtonTitle: "Confirm")
        alertView.show()
    }

    private func showAlertController() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
        
        
        let option1 = UIAlertAction(title: "option1", style: UIAlertActionStyle.Default) { [weak self] (_) -> Void in
            
            //self?.showAlertController() //블럭 안에서 self를 쓰면 메모리 누수의 위험이 있다. 따라서 약한 참조를 해야 한다. 블락 선언을 할 때.
            self?.changeImage()
        }
        
        let option2 = UIAlertAction(title: "option2", style: UIAlertActionStyle.Default) { [weak self] (_) -> Void in
            
            //self?.showAlertController() //블럭 안에서 self를 쓰면 메모리 누수의 위험이 있다. 따라서 약한 참조를 해야 한다. 블락 선언을 할 때.
            if self?.imageView.hidden == true {
                self?.imageView.hidden = false
            }
            else {
                self?.imageView.hidden = true
            }
            
        }
        
        
        alertController.addAction(option1)
        alertController.addAction(option2)
        
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func setupImage() {
        let image = UIImage(named: "image1")
        imageView.image = image //self생략 가능
    }
    
    private func changeImage() {
        if imageView.image == UIImage(named: "image1") {
            let image = UIImage(named: "image2")
            imageView.image = image //self생략 가능
        }
        else {
            let image = UIImage(named: "image1")
            imageView.image = image //self생략 가능
        }
        
    }
    
    
    /*
    
    숙제 
    
    앱을 켜면 이미지뷰 하나와 버튼이 두개. 
    버튼을 누르면 옵션이 2개 있는 경고창이 나오고, 
    첫 옵션을 선택하면 이미지가 바뀌고,
    두번째 옵션을 선택하면 이미지가 숨겨진다. 
    버튼을 각자 UIAlertController와 UIAlertView로 구현.
    
    */
    
    @IBAction func tappedButton1(sender:UIButton) {
        showAlertController()
    }
    
    @IBAction func tappedButton2(sender:UIButton) {
        
        switch button1.tintColor {
        case view.tintColor:
            button1.tintColor = UIColor.orangeColor()
        case UIColor.orangeColor():
            button1.tintColor = UIColor.redColor()
        case UIColor.redColor():
            button1.tintColor = UIColor.greenColor()
        case UIColor.greenColor():
            button1.tintColor = view.tintColor
        default:
            break
        }
        
        //if button1.tintColor == view.tintColor {
        //    button1.tintColor = UIColor.orangeColor()
        //} else {
        //    button1.tintColor = view.tintColor
        //}
        
    }
    
}

