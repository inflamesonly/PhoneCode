//
//  ViewController.swift
//  TelephoneCodeView
//
//  Created by macOS on 26.09.2018.
//  Copyright © 2018 macOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var telephoneLabel : UILabel?
    @IBOutlet weak var telephoneView : TelephoneCode?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.telephoneView?.delegate = self
        self.hideKeyboardWhenTappedAround()
    }

    
    @IBAction func getTelephone (_ sender:UIButton) {
        telephoneView?.getPhone()
    }
}

extension ViewController : TelephoneCodeDelegate {
    func get(telephone: String) {
        self.telephoneLabel?.text = telephone
    }
    
    func errorPhoneValidation() {
        self.telephoneLabel?.text = "Phone validation error"
    }
}

