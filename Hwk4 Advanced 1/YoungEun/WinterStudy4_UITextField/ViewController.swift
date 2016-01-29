//
//  ViewController.swift
//  WinterStudy4_UITextField
//
//  Created by Mac on 2016. 1. 23..
//  Copyright © 2016년 TheJoa. All rights reserved.
//

import UIKit
import KeychainAccess

class ViewController: UIViewController {

    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var button : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keychain = Keychain(service: "com.thejoa.WinterStudy4-UITextField")
        if let previousInput = try? keychain.get("input"){
            textField.text = previousInput
        }
    }
    
    @IBAction func tappedButton(sender : UIButton)
    {
        let input = textField.text
        let keychain = Keychain(service: "com.thejoa.WinterStudy4-UITextField")
        do {
            try keychain.set(input!, key: "input")
        }
        catch let error {
            print(error)
        }
        
        
    }


}
