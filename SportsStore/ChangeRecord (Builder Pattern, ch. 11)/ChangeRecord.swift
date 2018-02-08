//
//  ChangeRecord.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/7/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

class ChangeRecord: CustomStringConvertible {
    private let outerTag    : String
    private let productName : String
    private let catName     : String
    private let innerTag    : String
    private let value       : String
    
    private init(outer: String, name: String, category: String, inner: String, value: String) {
        outerTag    = outer
        productName = name
        catName     = category
        innerTag    = inner
        self.value  = value
    }
    
    var description: String {
        return """
        <\(outerTag)><\(innerTag) name="\(productName)"  category="\(catName)">\(value)</\(innerTag)></\(outerTag)>
        """
    }
}



