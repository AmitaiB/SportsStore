//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/7/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

// MARK: - StockValueFormatters
protocol StockValueFormatter {
    func format(total: Double) -> String
}

class DollarStockValueFormatter: StockValueFormatter {
    func format(total: Double) -> String {
        let formatted = Utils.currencyString(from: total)
        return "\(formatted)"
    }
}

class PoundStockValueFormatter: StockValueFormatter {
    func format(total: Double) -> String {
        let formatted = Utils.currencyString(from: total)
        return "£\(formatted.dropFirst())"
    }
}


// MARK:- StockValueConverters
protocol StockValueConverter {
    func convert(total: Double) -> Double
}

class DollarStockValueConverter: StockValueConverter {
    func convert(total: Double) -> Double {
        return total
    }
}

class PoundStockValueConverter: StockValueConverter {
    func convert(total: Double) -> Double {
        return 0.60338 * total
    }
}
