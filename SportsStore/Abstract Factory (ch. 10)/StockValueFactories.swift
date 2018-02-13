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
        case eur
    }
    
    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?
    
    class func getFactory(for curr: Currency) -> StockTotalFactory {
        var factory: StockTotalFactory
        switch curr {
        case .usd:
            factory = DollarStockTotalFactory.shared
        case .gbp:
            factory = PoundStockTotalFactory.shared
        case .eur:
            factory = EuroHandlerAdapter.shared
        }
        
        return factory
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
}

fileprivate class EuroHandlerAdapter: StockTotalFactory, StockValueFormatter, StockValueConverter {
    static let shared = EuroHandlerAdapter()
    
    // StockValueFormatter protocol
    func format(total: Double) -> String {
        return euroHandler.getDisplayString(for: total)
    }
    
    // StockValueConverter protocol
    func convert(total: Double) -> Double {
        return euroHandler.getCurrencyAmount(total)
    }
    
    private override init() {
        super.init()
        // StockTotalFactory protocol
        formatter = self
        converter = self
    }
    
    private let euroHandler = EuroHandler()
}


