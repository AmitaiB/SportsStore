//
//  Euro.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/13/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

public let USD_TO_EUR_RATE = 0.76164

// This is similar in functionality to the StockValueConverter from the factory pattern (it takes USD, and returns formatted strings), but has a different implementation. Adapter! (plus factory)
class EuroHandler {
    func getDisplayString(for amount: Double) -> String {
        let formatted = Utils.currencyString(from: amount)
        return "€\(formatted.dropFirst())"
    }
    
    func getCurrencyAmount(_ amount: Double) -> Double {
        return USD_TO_EUR_RATE * amount
    }
}
