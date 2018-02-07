//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/7/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case usd
        case gbp
    }
    
    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?
    
//    class func getFactory(for curr: Currency) -> StockTotalFactory {
//        return curr == .usd ?
//    }
}


fileprivate class DollarStockTotalFactory: StockTotalFactory {
    fileprivate override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }
    
    static let shared = DollarStockTotalFactory()
}

fileprivate class PoundStockTotalFactory: StockTotalFactory {
    fileprivate override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }
    
    static let shared = PoundStockTotalFactory()
}



