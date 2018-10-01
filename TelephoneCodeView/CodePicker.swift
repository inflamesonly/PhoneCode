//
//  CodePicker.swift
//  TelephoneCodeView
//
//  Created by macOS on 28.09.2018.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation
import UIKit

protocol CodePickerDelegate : class {
    func pickerViewDidSelect(country : Country)
}

class CodePicker : UIView {
    
    let pickerHeight : CGFloat = 240.0
    
    private var code = ""
    private var bckView : UIView!
    private var pickerBckView : UIView!
    private var picker : UIPickerView!
    
    private var applyButton : UIButton!
    private var closeButton : UIButton!
    
    private var pickerArray = [Country]()
    
    
    private var selectedIndex = 0
    
    weak var delegate : CodePickerDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, code : String) {
        self.init(frame: frame)
        self.code = code
        setSubviews()
    }
    
    private func setSubviews () {
        getCountryList()
        createBckView()
        createPickerView()
        createCloseButton()
        createApllyButton()
        createPicker()
        findCode(code: self.code)
        addDetectTapToBckView()
        open()
    }
    
    private func getCountryList () {
        let countryList = LocalCountriesArray().countriesArray
        for country in countryList! {
            pickerArray.append(country as! Country)
        }
    }
    
    private func createBckView () {
        self.bckView = UIView(frame: self.frame)
        self.bckView.backgroundColor = UIColor.black
        self.bckView.alpha = 0.5
        self.addSubview(bckView!)
    }
    
    private func createPickerView () {
        self.pickerBckView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: self.bounds.width, height: pickerHeight))
        self.pickerBckView.backgroundColor = UIColor.white
        self.addSubview(pickerBckView!)
    }
    
    
    private func createCloseButton () {
        self.closeButton = UIButton(frame: CGRect(x: 15, y: 15, width: 25, height: 16))
        closeButton.setImage(UIImage(named: "Close.png"), for: .normal)
        self.pickerBckView.addSubview(closeButton)
        closeButton.imageView?.contentMode = .scaleAspectFit
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    private func createApllyButton () {
        self.applyButton = UIButton(frame: CGRect(x: self.bounds.width - 15 - 25, y: 15, width: 25, height: 16))
        applyButton.setImage(UIImage(named: "Apply.png"), for: .normal)
        self.pickerBckView.addSubview(applyButton)
        applyButton.addTarget(self, action: #selector(apply), for: .touchUpInside)
        applyButton.imageView?.contentMode = .scaleAspectFit
    }
    
    @objc private func apply(sender: UIButton!) {
        let country = pickerArray[picker.selectedRow(inComponent: 0)]
        self.delegate?.pickerViewDidSelect(country: country)
        self.close()
    }
    
    private func createPicker () {
        self.picker = UIPickerView(frame: CGRect(x: 0, y: 30, width: self.bounds.width, height: pickerBckView.bounds.height - 30))
        self.picker.delegate = self
        self.picker.dataSource = self
        self.pickerBckView.addSubview(picker!)
        picker.reloadAllComponents()
    }
    
    private func addDetectTapToBckView () {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        self.bckView.addGestureRecognizer(tapRecognizer)
    }
    
    private func open () {
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.pickerBckView.frame = CGRect(x: 0, y: self.frame.height - self.pickerHeight, width: self.bounds.width, height: self.pickerHeight)
        }
    }
    
    @objc private func close () {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerBckView.frame = CGRect(x: 0, y: self.frame.height, width: self.bounds.width, height: self.pickerHeight)
            self.layoutIfNeeded()
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @objc private func tapped(gestureRecognizer: UITapGestureRecognizer) {
        self.close()
    }
    
    private func findCode (code : String) {
        let countryList = pickerArray
        var index = 0
        for country in countryList {
            let arrCountry = country 
            if code == arrCountry.code {
                self.selectedIndex = index
                self.picker.selectRow(self.selectedIndex, inComponent: 0, animated: false)
            }
            index += 1
        }
    }
}

extension CodePicker : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerArray[row].code!)  \(pickerArray[row].name!)"
    }
}

extension CodePicker : UIPickerViewDelegate {

}

