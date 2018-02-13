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
    
    fileprivate init(outer: String, name: String, category: String, inner: String, value: String) {
        outerTag    = outer
        productName = name
        catName     = category
        innerTag    = inner
        self.value  = value
    }
    
    var description: String {
        return """
        <\(outerTag)><\(innerTag) name="\(productName)" category="\(catName)">\(value)</\(innerTag)></\(outerTag)>
        """
    }
}


class ChangeRecordBuilder {
    var outerTag    : String
    var innerTag    : String
    var productName : String?
    var category    : String?
    var value       : String?

    init() {
        outerTag = "change"
        innerTag = "product"
    }
    
    var changeRecord: ChangeRecord? {
        get {
            if
                let productName = productName,
                let category    = category,
                let value       = value
            {
                return ChangeRecord(outer: outerTag, name: productName, category: category, inner: innerTag, value: value)
            }
            
            return nil
        }
    }
    /// Problem: How do we know if a required value is missing from the builder? Better to implement it with functions like in the earlier example in the book.

}
