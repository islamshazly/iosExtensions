//
//  URLExtension.swift
//  Baheeg
//
//  Created by Islam Elshazly on 6/11/18.
//  Copyright © 2018 krashless.com. All rights reserved.
//

import UIKit


extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    
    
    var params: [String: String]? {
        if let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) {
            if let queryItems = urlComponents.queryItems {
                var params = [String: String]()
                queryItems.forEach{
                    params[$0.name] = $0.value
                }
                return params
            }
        }
        return nil
    }
    
}

