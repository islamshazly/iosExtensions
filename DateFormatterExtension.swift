//
//  DateFormatterExtension.swift
//  Ostazi Profile
//
//  Created by Islam Elshazly on 4/14/18.
//  Copyright © 2018 Karshless. All rights reserved.
//

import UIKit

extension DateFormatter {
    
    open class var OstaziDisplayFormat: DateFormatter {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateStyle = .long
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: Language.language.rawValue)
        return dateFormatter
    }

    
    open class var OstaziAPIFormat: DateFormatter {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = ostaziFormattedDate
//        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter
    }
    
    
}
