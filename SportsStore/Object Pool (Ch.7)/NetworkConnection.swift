//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let flyweight: NetConnFlyweight
    
    init() {
        flyweight = NetConnFlyweightFactory.createFlyweight()
    }
    
    func getStockLevel(name: String) -> Int? {
    // mimics unreliability of actual network connection
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return flyweight.getStockLevel(name)
    }
    
    func setStockLevel(productName name: String, level: Int) {
        print("\nStock update: \(name) = \(level)")
    }
}
