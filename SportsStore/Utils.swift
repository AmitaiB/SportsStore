//
//  Utils.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/14/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Utils {
    class func currencyString(from number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
