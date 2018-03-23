//
//  NetworkConnectionFlyweight.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 3/5/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

protocol NetConnFlyweight {
    func getStockLevel(_ name: String) -> Int?
}

class NetConnFlyweightImpl: NetConnFlyweight {
    private let extrinsicData: [String: Int]
    
    fileprivate init(data: [String: Int]) {
        extrinsicData = data
    }
    
    // Use getters and hide the backing dictionary in case
    // the implementation of data changes (API will remain the same).
    func getStockLevel(_ name: String) -> Int? {
        return extrinsicData[name]
    }
}

class NetConnFlyweightFactory {
    class func createFlyweight() -> NetConnFlyweight {
        return NetConnFlyweightImpl(data: stockData)
    }
    
    // The default extrinsic data shared by the flyweight
    private class var stockData: [String: Int] {
        get {
            struct singletonWrapper {
                static let singleton = [
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
            }
            return singletonWrapper.singleton
        }
    }
}
