//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let stockData = [
        "Kayak": 10,
        "Lifejacket": 14,
        "Soccer Ball": 32,
        "Corner Flags": 1,
        "Stadium": 4,
        "Thinking Cap": 8,
        "Unsteady Chair": 3,
        "Human Chess Board": 2,
        "Bling-Bling King": 4
    ]
    
    func getStockLevel(name: String) -> Int? {
    // mimics unreliability of actual network connection
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return stockData[name]
    }
}
