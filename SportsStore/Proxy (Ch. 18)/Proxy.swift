//
//  Proxy.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 3/23/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

// Unnecessary for the pattern, but helpful in keeping boundaries clear
protocol StockServer {
    func getStockLevel(for product: String, callback: (String, Int) -> Void)
    func setStockLevel(for product: String, stockLevel: Int)
}

class StockServerFactory {
    class func getStockServer() -> StockServer {
        return server
    }
    
    private class var server: StockServer {
        struct singletonWrapper {
            static let singleton = StockServerProxy()
        }
        return singletonWrapper.singleton
    }
}

class StockServerProxy: StockServer {
    func getStockLevel(for productName: String, callback: (String, Int) -> Void) {
        let stockConn = NetworkPool.getConnection()
        let level = stockConn.getStockLevel(name: productName)
        if let level = level {
            callback(productName, level)
        }
        NetworkPool.returnA(connection: stockConn)
    }
    
    func setStockLevel(for product: String, stockLevel: Int) {
        let stockConn = NetworkPool.getConnection()
        stockConn.setStockLevel(productName: product, level: stockLevel)
        NetworkPool.returnA(connection: stockConn)
    }
}
