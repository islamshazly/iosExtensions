//
//  IntExtension.swift
//  Baheeg
//
//  Created by Islam Elshazly on 5/29/18.
//  Copyright © 2018 krashless.com. All rights reserved.
//

import UIKit

extension Int {
    
    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()
        
        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "hint_thousand_likes".localized),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
        // you can add more !
        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()
        
        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
            
        
        numFormatter.locale = Language.language == Language.arabic ? Locale(identifier: "ar") :  Locale(identifier: "en_US")
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1
        
        
        return numFormatter.string(from: NSNumber(value: value))!
    }
    
}
