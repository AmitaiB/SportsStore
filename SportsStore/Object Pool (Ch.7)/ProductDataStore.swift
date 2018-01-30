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
        for aProduct in productData {
            networkQ.async {
                let stockConn = NetworkPool.getConnection()
                let level = stockConn.getStockLevel(name: aProduct.name)
                if let level = level {
                    aProduct.stockLevel = level
                    self.uiQ.async {
                        if let callback = self.callback {
                            callback(aProduct)
                        }
                    }
                }
                NetworkPool.returnA(connection: stockConn)
            }
        }
        return productData
    }
    
    
    private var productData: [Product] = [
        Product.createProduct(name: "Kayak",        description: "A boat for one person", category: "Watersports", price: 275.0, stockLevel: 0),
        Product.createProduct(name: "Lifejacket",   description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 0),
        Product.createProduct(name: "Soccer Ball",  description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 0),
        Product.createProduct(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 0),
        Product.createProduct(name: "Stadium",      description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 0),
        Product.createProduct(name: "Thinking Cap", description: "Improve your brain effciency by 75%", category: "Chess", price: 16.0, stockLevel: 0),
        Product.createProduct(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 0),
        Product.createProduct(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stockLevel: 0),
        Product.createProduct(name: "Bling-Bling King", description: "Gold-plated, diamond studded King", category: "Chess", price: 1200.0, stockLevel: 0)
    ]
}
