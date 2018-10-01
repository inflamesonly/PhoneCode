//
//  LocalCountriesArray.swift
//  TelephoneCodeView
//
//  Created by macOS on 28.09.2018.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

class LocalCountriesArray : NSArray {
    
    var countriesArray : NSArray?
    
    override init() {
        super.init()
        self.parseLocalJSON()
    }
    
    override init(objects: UnsafePointer<AnyObject>?, count cnt: Int) {
        super.init()
        self.parseLocalJSON()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        self.parseLocalJSON()
    }
    
    private func parseLocalJSON () {
        self.countriesArray = NSArray()
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let array : NSMutableArray = NSMutableArray()
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Array<Dictionary<String, Any>> {
                    for country in jsonResult {
                        let countryObj = Country(name: country["name"] as! String,
                                                 code: country["dial_code"]as! String,
                                                 image: country["image"]as! String)
                        array.add(countryObj)
                        
                    }
                }
                self.countriesArray = array.copy() as? NSArray
                print("Done parse JSON")
            } catch {
                print("Error parse local JSON")
            }
        }
    }
}
