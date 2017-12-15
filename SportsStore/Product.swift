//
//  Product.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/14/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Product {
    var name: String
    var description: String
    var category: String
    var price: Double
    var stock: Int
    
    init(name aName: String, description aDescription: String, category aCategory: String, price aPrice: Double, stock aStockVal: Int) {
        name = aName
        description = aDescription
        category = aCategory
        price = aPrice
        stock = aStockVal
    }
}
