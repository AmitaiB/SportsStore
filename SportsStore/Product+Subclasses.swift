//
//  Product.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/14/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {
    // MARK: stored properties
    private(set) var name: String
    private(set) var productDescription: String
    private(set) var category: String
    private var stockBackingValue = 0
    private var priceBackingValue = 0.0
    fileprivate var salesTaxRate  = 0.2
    
    // MARK: computed properties
    var stockLevel: Int {
        get { return stockBackingValue }
        set { stockBackingValue = max(0, newValue) }
    }
    
    private(set) var price: Double {
        get { return priceBackingValue }
        set { priceBackingValue = max(1, newValue) }
    }
    
    var stockValue: Double {
        let taxedPrice = price * (1 + salesTaxRate)
        return taxedPrice * Double(stockLevel)
    }
    
    var upsells: [UpsellOpportunities] {
        get { return Array() }
    }

    // MARK: methods
    required init(name: String,
         description: String,
         category: String,
         price: Double,
         stockLevel: Int)
    {
        self.name               = name
        self.productDescription = description
        self.category           = category
        // Must be called after stored properties, before computed properties
        super.init()
        self.price              = price
        self.stockLevel         = stockLevel
    }
    
    
    func calculateTax(rate: Double) -> Double {
        return min(10, price * rate)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: name, description: productDescription, category: category, price: price, stockLevel: stockLevel)
    }
    
    
    // factory method
    class func createProduct(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
        var productType: Product.Type
        
        switch category {
        case "Watersports":
            productType = WatersportsProduct.self
        case "Soccer":
            productType = SoccerProduct.self
        default:
            productType = Product.self
        }
        
        return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
    }
    
}

enum UpsellOpportunities {
    case swimmingLessons
    case mapOfLakes
    case soccerVideos
}


// MARK: - WatersportsProduct
class WatersportsProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int)
    {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        
        salesTaxRate = 0.10
    }
    
    override var upsells: [UpsellOpportunities] {
        return [.swimmingLessons, .mapOfLakes]
    }
}


// MARK: - SoccerProduct
class SoccerProduct: Product {
    required init(name aName: String, description aDescription: String, category aCategory: String, price aPrice: Double, stockLevel aStockVal: Int)
        {
            super.init(name: aName, description: aDescription, category: aCategory, price: aPrice, stockLevel: aStockVal)
            
            salesTaxRate = 0.25
        }
        
        override var upsells: [UpsellOpportunities] {
            return [.soccerVideos]
        }
}





