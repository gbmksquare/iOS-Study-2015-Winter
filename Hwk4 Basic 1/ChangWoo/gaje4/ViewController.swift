//
//  ViewController.swift
//  gaje4
//
//  Created by SonChang Woo on 2016. 1. 24..
//  Copyright © 2016년 SonChangWoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let previous = defaults.stringForKey("input") else {
            textField.placeholder = "힝"
            return
        } 
        
        textField.text = previous
    }
    
    @IBAction func tappedButton(sender: UIButton) {
        let input = textField.text
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue(input, forKey: "input")
        defaults.synchronize()
    }

}

