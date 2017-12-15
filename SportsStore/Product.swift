//
//  Product.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/14/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Product {
    private(set) var name: String
    private(set) var description: String
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
        description = aDescription
        category = aCategory
        price = aPrice
        stockLevel = aStockVal
    }
    
    
    func calculateTax(rate: Double) -> Double {
        return min(10, price * rate)
    }
}
