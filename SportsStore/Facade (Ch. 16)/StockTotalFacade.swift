//
//  StockTotalFacade.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/20/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

typealias StockTotal = (quantity: Int, value: Double)

class StockTotalFacade {
    class func formatCurrency(amount: Double, in currency: StockTotalFactory.Currency) -> String? {
        
        let factory = StockTotalFactory.getFactory(for: currency)
        if let totalAmount = factory.converter?.convert(total: amount),
            let formatted = factory.formatter?.format(total: totalAmount) {
            return formatted
        }
        return nil
    }
}

