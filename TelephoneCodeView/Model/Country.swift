//
//  Country.swift
//  TelephoneCodeView
//
//  Created by macOS on 28.09.2018.
//  Copyright © 2018 macOS. All rights reserved.
//

import Foundation

struct Country {
    var name : String?
    var code : String?
    var image : String?
    
    init(name: String, code: String, image: String) {
        self.name = name
        self.code = code
        self.image = image
    }
}
