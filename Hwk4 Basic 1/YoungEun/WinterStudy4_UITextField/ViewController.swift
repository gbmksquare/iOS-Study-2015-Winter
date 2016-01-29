//
//  ViewController.swift
//  WinterStudy4_UITextField
//
//  Created by Mac on 2016. 1. 23..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var button : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let previousInput = defaults.stringForKey("input"){
            textField.text = previousInput
        }
    }
    
    @IBAction func tappedButton(sender : UIButton)
    {
        let input = textField.text
        let defaults = NSUserDefaults.standardUserDefaults() //싱글턴 이것은 사용자들에게 보인다. Flag(첫실행인지 아닌지) (마지막에 어떤 탭에 있었는 지 이런 정보들을 저장한다)
        defaults.setValue(input, forKey: "input")
        defaults.synchronize() //저장할 시점에 이걸 써준다. 안써도 알아서 되긴하는데 느리고 사용자가 그만큼 안기다려줄수있음
    }


}

class Singleton {
    static let sharedClass = Singleton()
}

