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
    
    init(callback: @escaping (T) -> ()) {
        self.callback = callback
    }
    
    func log(item: T) {
        dataItems.append(item.copy() as! T)
        callback(item)
    }
    
    func processItems(callback: (T)->() ) {
        dataItems.forEach { callback($0) }
    }
}
