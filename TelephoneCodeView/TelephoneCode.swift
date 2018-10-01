//
//  TelephoneCode.swift
//  TelephoneCodeView
//
//  Created by macOS on 26.09.2018.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import UIKit


protocol TelephoneCodeDelegate : class {
    func get(telephone : String)
    func errorPhoneValidation()
}


@IBDesignable open class TelephoneCode: UIView {
    
    private var backgroundView = UIView()
    private var codeButton = UIButton()
    private var phoneTextField = UITextField()
    
    private var delimiterView = UIView()
    
    
    /**
     Этот параметр отвечает за колличество цифр после кода страны.Если телефон имеет меньше цифр чем имеет этот параметр, то после запроса номера телефона будет ошибка текстового поля.
     default = 9 - Ukraine phone standard
     */
    var telephoneMaxLenght = 9
    var telephone = ""
    
    var isValidate = false
    
    
    weak var delegate : TelephoneCodeDelegate?
    
    @IBInspectable var delimiterViewColor: UIColor = UIColor.black {
        didSet {
            delimiterView.backgroundColor = delimiterViewColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            backgroundView.layer.cornerRadius = cornerRadius
            backgroundView.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var backgroundViewColor: UIColor = UIColor.white {
        didSet {
            backgroundView.backgroundColor = backgroundViewColor
        }
    }
    
    @IBInspectable var borderWith: CGFloat = 0 {
        didSet {
            backgroundView.layer.borderWidth = borderWith
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            backgroundView.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var codeText: String = "+38" {
        didSet {
            codeButton.setTitle(codeText, for: .normal)
        }
    }
    
    @IBInspectable var codeTextColor: UIColor = UIColor.blue {
        didSet {
            codeButton.setTitleColor(codeTextColor, for: .normal)
        }
    }
    
    @IBInspectable var phonePlaceholder: String = "Номер телефона" {
        didSet {
            self.phoneTextField.placeholder = phonePlaceholder
        }
    }
    
    @IBInspectable var phoneTextColor: UIColor = UIColor.white {
        didSet {
            self.phoneTextField.textColor = phoneTextColor
        }
    }
    
    @IBInspectable var placeholderTextColor: UIColor = UIColor.white {
        didSet {
            self.phoneTextField.attributedPlaceholder = NSAttributedString(string:self.phoneTextField.placeholder ?? "",
                                attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
        }
    }
    
    // MARK:- inits
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        self.telephoneMaxLenght = self.codeText.count + self.telephoneMaxLenght
        self.setValues()
        self.addSubviewes()
        self.setupAutoLayoutBackgroundView()
        self.setupAutoLayoutCodeButton()
        self.setupAutoLayoutDelimiterView()
        self.setupAutoLayoutTextField()
    }
    
    // MARK:- config subviews
    private func addSubviewes () {
        self.addSubview(backgroundView)
        self.backgroundView.addSubview(codeButton)
        self.backgroundView.addSubview(delimiterView)
        self.backgroundView.addSubview(phoneTextField)
    }
    
    private func setValues () {
        codeButton.setTitle(codeText, for: .normal)
        codeButton.setTitleColor(codeTextColor, for: .normal)
        codeButton.addTarget(self, action: #selector(callCodePicker), for: .touchUpInside)
        delimiterView.backgroundColor = delimiterViewColor
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.masksToBounds = true
        backgroundView.backgroundColor = backgroundViewColor
        backgroundView.layer.borderWidth = borderWith
        backgroundView.layer.borderColor = borderColor.cgColor
        phoneTextField.keyboardType = .numberPad
        phoneTextField.delegate = self
        self.phoneTextField.placeholder = phonePlaceholder
        self.phoneTextField.attributedPlaceholder = NSAttributedString(string:self.phoneTextField.placeholder!,
                            attributes: [NSAttributedString.Key.foregroundColor: placeholderTextColor])
    }
    
    @objc private func callCodePicker(sender: UIButton!) {
        if let topController = UIApplication.topViewController() {
            let codePicker = CodePicker(frame: CGRect(x: 0, y: 0, width: topController.view.bounds.width, height: topController.view.bounds.height), code: self.codeButton.titleLabel!.text!)
            codePicker.delegate = self
            topController.view.addSubview(codePicker)
        }
    }
    
    // MARK:- set autolayout UI objects
    private func setupAutoLayoutBackgroundView() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupAutoLayoutCodeButton() {
        let fontSize = codeButton.titleLabel!.text!.widthOfString(usingFont: UIFont.systemFont(ofSize: 17))
        codeButton.translatesAutoresizingMaskIntoConstraints = false
        codeButton.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 20).isActive = true
        codeButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
        codeButton.widthAnchor.constraint(equalToConstant: fontSize + 15).isActive = true
        codeButton.setNeedsLayout()
    }
    
    private func setupAutoLayoutDelimiterView() {
        delimiterView.translatesAutoresizingMaskIntoConstraints = false
        delimiterView.rightAnchor.constraint(equalTo: codeButton.rightAnchor, constant: 5).isActive = true
        delimiterView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        delimiterView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        delimiterView.centerYAnchor.constraint(equalTo: codeButton.centerYAnchor).isActive = true
    }
    
    private func setupAutoLayoutTextField() {
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.leftAnchor.constraint(equalTo: self.delimiterView.leftAnchor, constant: 10).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        phoneTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    func getPhone () {
        if self.checkErrorLengthPhoneCount(count: self.codeText.count + (self.phoneTextField.text?.count)!) {
            self.delegate?.get(telephone: self.telephone)
        }
    }
}

// MARK:- CodePickerDelegate
extension TelephoneCode : CodePickerDelegate {
    func pickerViewDidSelect(country : Country) {
        codeText = country.code!
        codeButton.setTitle(codeText, for: .normal)
    }
}

// MARK:- UITextFieldDelegate
extension TelephoneCode : UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        if range.location + (self.codeText.count) < self.telephoneMaxLenght {
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                self.getPhone(text: txtAfterUpdate)
//                return TelephoneNumberValidator.formattedTextField(textField, shouldChangeCharactersIn: range, replacementString: string)
            }
            return true
        } else {
            print("The international format should have no more than 16 characters without the plus sign")
            return false
        }
    }
    
    func checkIsNumberInto(textField : UITextField) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: textField.text!)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func checkErrorLengthPhoneCount (count : Int) -> Bool {
        if count != self.telephoneMaxLenght {
            self.shake()
            self.delegate?.errorPhoneValidation()
            return false
        } else {
            return true
        }
    }
    
    func getPhone (text : String) {
        let fullPhone = "\(self.codeText)\(text)"
        self.telephone = fullPhone
    }
}
