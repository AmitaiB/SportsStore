//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/7/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

// Our abstract factory
class StockTotalFactory {
    enum Currency {
        case usd
        case gbp
    }
    
    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?
    
    class func getFactory(for curr: Currency) -> StockTotalFactory {
        return curr == .usd ?
            DollarStockTotalFactory.shared : PoundStockTotalFactory.shared
    }
}


fileprivate class DollarStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }
    
    static let shared = DollarStockTotalFactory()
}

fileprivate class PoundStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }
    
    static let shared = PoundStockTotalFactory()
}



