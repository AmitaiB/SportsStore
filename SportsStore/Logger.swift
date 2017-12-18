//
//  Logger.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/16/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

class Logger<T: NSObject & NSCopying> {
    var dataItems = [T]()
    var callback: (T) -> ()
    var arrayQ = DispatchQueue(label: "arrayQ", attributes: .concurrent)
    
    init(callback: @escaping (T) -> ()) {
        self.callback = callback
    }
    
    func log(item: T) {
        // Barrier blocks are like temporary synchronous queue-mode - will finish all read ops before execution.
        arrayQ.async(flags: .barrier) {
            // This is where the Protype Pattern magic happens!
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }
    
    func processItems(callback: (T)->() ) {
        arrayQ.sync {
            dataItems.forEach { callback($0) }
        }
    }
}
