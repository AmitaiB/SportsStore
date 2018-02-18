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
        get { return price * Double(stockLevel) }
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
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: name, description: productDescription, category: category, price: price, stockLevel: stockLevel)
    }
    
    
    // factory method
    class func create(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
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
    
    override var description: String { return productDescription }
}


class ProductComposite: Product {
    private let products: [Product]
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError("Not implemented")
    }
    
    init(name: String, description: String, category: String, stockLevel: Int, products: Product...) {
        self.products = products
        super.init(name: name, description: description, category: category, price: 0, stockLevel: stockLevel)
    }
    
    
    override var price: Double {
        return products.reduce(0, {total, p in total + p.price})
    }
}


// MARK: - WatersportsProduct
class WatersportsProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int)
    {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        
        salesTaxRate = 0.10
    }
}


// MARK: - SoccerProduct
class SoccerProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int)
    {
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        
            salesTaxRate = 0.25
        }
}





