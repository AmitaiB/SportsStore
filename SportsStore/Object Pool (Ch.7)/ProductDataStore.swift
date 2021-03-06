//
//  ProductDataStore.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/21/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

final class ProductDataStore {
    var callback: ((Product) -> Void)?
    private var networkQ: DispatchQueue
    private var uiQ: DispatchQueue
    lazy var products = loadData()
    
    init() {
        networkQ = DispatchQueue.global(qos: .background)
        uiQ = DispatchQueue.main
    }
    
    private func loadData() -> [Product] {
        var products = [Product]()
        
        for product in productData {
            var p: Product = LowStockIncreaseDecorator(product: product)
            if p.category == "Soccer" {
                p = SoccerDecreaseDecorator(product: p)
            }
            
            networkQ.async {
                StockServerFactory.getStockServer().getStockLevel(for: p.name, callback: { (name, stockLevel) in
                    p.stockLevel = stockLevel
                    self.uiQ.async {
                        if let callback = self.callback {
                            callback(p)
                        }
                    }
                })
            }
            products.append(p)
        }
        return products
    }
    
    
    private var productData: [Product] = [
        ProductComposite(name: "Running Pack", description: "Complete Running Outfit", category: "Running", stockLevel: 10, products:
            Product.create(name: "Shirt", description: "Running Shirt", category: "Running", price: 42, stockLevel: 10),
            Product.create(name: "Shorts", description: "Running Shorts", category: "Running", price: 30, stockLevel: 10),
            Product.create(name: "Shoes", description: "Running Shoes", category: "Running", price: 120, stockLevel: 10),
            ProductComposite(name: "Headgear", description: "Hat, etc.", category: "Running", stockLevel: 10, products:
               Product.create(name: "Hat", description: "Running Hat", category: "Running", price: 10, stockLevel: 10),
               Product.create(name: "Sunglasses", description: "Glasses", category: "Running", price: 10, stockLevel: 10)
            )
        ),
        Product.create(name: "Kayak",        description: "A boat for one person", category: "Watersports", price: 275.0, stockLevel: 0),
        Product.create(name: "Lifejacket",   description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 0),
        Product.create(name: "Soccer Ball",  description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 0),
        Product.create(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 0),
        Product.create(name: "Stadium",      description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 0),
        Product.create(name: "Thinking Cap", description: "Improve your brain effciency by 75%", category: "Chess", price: 16.0, stockLevel: 0),
        Product.create(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 0),
        Product.create(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stockLevel: 0),
        Product.create(name: "Bling-Bling King", description: "Gold-plated, diamond studded King", category: "Chess", price: 1200.0, stockLevel: 0)
    ]
    
}




