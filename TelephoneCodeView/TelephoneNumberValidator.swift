//
//  TelephoneNumberValidator.swift
//  StarClub
//
//  Created by macOS on 12.12.17.
//  Copyright © 2017 macOS. All rights reserved.
//

import UIKit

class TelephoneNumberValidator: NSObject {
    
//    class func formattedTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let newString: String? = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
//        let components = newString?.components(separatedBy: CharacterSet.decimalDigits.inverted)
//        let decimalString: String? = components?.joined(separator: "")
//        let length: Int = decimalString?.count ?? 0
//        let hasLeadingOne: Bool = length > 0 && decimalString?[(decimalString?.index((decimalString?.startIndex)!, offsetBy: 0))!] == "9"
//        if length == 0 || (length > 12 && !hasLeadingOne) || (length > 13) {
//            textField.text = decimalString
//            return false
//        }
//
//        var index: Int = 0
//        var formattedString = ""
////        formattedString += "+38 "
////        index += 2
//
//        if length - index > 3 {
//            let areaCode: String = (decimalString! as NSString).substring(with: NSRange(location: index, length: 3))
//            formattedString += "(\(areaCode)) "
//            index += 3
//        }
//        if length - index > 3 {
//            let prefix: String = (decimalString! as NSString).substring(with: NSRange(location: index, length: 3))
//            formattedString += "\(prefix)-"
//            index += 3
//        }
//        if length - index > 2 {
//            let prefix: String = (decimalString! as NSString).substring(with: NSRange(location: index, length: 2))
//            formattedString += "\(prefix)-"
//            index += 2
//        }
//
//        let remainder: String? = (decimalString as NSString?)?.substring(from: index)
//        formattedString += remainder ?? ""
//        textField.text = formattedString
//        return false
//    }
    
    class func formattedNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, mask: String) -> String {
//        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        let mask = "+X (XXX) XXX XX-XX"
        
        var result = ""
        var index = string.startIndex
        for ch in mask {
            if index == string.endIndex {
                break
            }
            if ch == "X" {
                result.append(string[index])
                index = string.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

