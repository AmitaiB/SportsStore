//
//  EventBridge.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 2/14/18.
//  Copyright © 2018 Amitai Blickstein. All rights reserved.
//

import Foundation

typealias ContextCallback = (String, Int) -> Void

/// Simple bridge which nevertheless separates the source of the event from the destination, allowing the modification of one without the other.
class EventBridge {
    private let outputCallback: ContextCallback
    
    init(callback: @escaping ContextCallback) {
        outputCallback = callback
    }
    
    var inputCallback: (Product) -> Void {
        return { self.outputCallback($0.name, $0.stockLevel) }
    }
}
