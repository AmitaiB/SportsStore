//
//  ProductDecorators.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/15/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

// Core/Base Decorator
class PriceDecorator: Product {
    fileprivate let wrappedProduct: Product
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        fatalError("Not supported")
    }
    
    init(product: Product) {
        wrappedProduct = product
        super.init(name: wrappedProduct.name, description: wrappedProduct.description, category: wrappedProduct.category, price: wrappedProduct.price, stockLevel: wrappedProduct.stockLevel)
    }
    
    override var description: String {
        return wrappedProduct.description
    }
}



// Concrete Decorators
class LowStockIncreaseDecorator: PriceDecorator {
    override var price: Double {
        let price = wrappedProduct.price
        return stockLevel > 4 ?
            price : price * 1.5
    }
}


class SoccerDecreaseDecorator: PriceDecorator {
    override var price: Double {
        return super.wrappedProduct.price * 0.5
    }
}
