//
//  Product.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/14/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {
    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockBackingValue = 0
    private var priceBackingValue = 0.0
    
    var stockLevel: Int {
        get { return stockBackingValue }
        set { stockBackingValue = max(0, newValue) }
    }
    
    private(set) var price: Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }
    
    var stockValue: Double {
        return price * Double(stockLevel)
    }
    
    
    init(name aName: String, description aDescription: String, category aCategory: String, price aPrice: Double, stockLevel aStockVal: Int) {
        name = aName
        productDescription = aDescription
        category = aCategory
        
        // Must be called after stored properties, before computed properties
        super.init()
        
        price = aPrice
        stockLevel = aStockVal
    }
    
    
    func calculateTax(rate: Double) -> Double {
        return min(10, price * rate)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: name, description: productDescription, category: category, price: price, stockLevel: stockLevel)
    }
}
