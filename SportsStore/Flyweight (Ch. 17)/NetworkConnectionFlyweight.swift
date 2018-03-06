//
//  NetworkConnectionFlyweight.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 3/5/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

protocol NetConnFlyweight {
    func getStockLevel(name: String) -> Int?
}

class NetConnFlyweightImpl: NetConnFlyweight {
    private let extrinsicData: [String: Int]
    
    private init(data: [String: Int]) {
        extrinsicData = data
    }
    
    // Use getters and hide the backing dictionary in case
    // the implementation of data changes (API will remain the same).
    func getStockLevel(name: String) -> Int? {
        return extrinsicData[name]
    }
}
