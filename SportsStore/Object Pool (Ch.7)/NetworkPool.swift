//
//  NetworkPool.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/20/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

final class NetworkPool {
    static var shared = NetworkPool()
    
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: DispatchSemaphore
    private var queue: DispatchQueue
    private var itemsCreated = 0
    
    private init() {
        semaphore = DispatchSemaphore(value: connectionCount)
        queue = DispatchQueue(label: "networkpoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection {
        semaphore.wait()
        var result: NetworkConnection? = nil
        queue.sync {
            if connections.count > 0 {
                result = connections.remove(at: 0)
            } else if itemsCreated < connectionCount {
                result = NetworkConnection()
                itemsCreated += 1
            }
        }
        return result!
    }
    
    private func doReturn(connection: NetworkConnection) {
        queue.async {
            self.connections.append(connection)
            self.semaphore.signal()
        }
    }
    
    // MARK: Public API
    class func getConnection() -> NetworkConnection {
        return shared.doGetConnection()
    }
    
    class func returnA(connection: NetworkConnection) {
        shared.doReturn(connection: connection)
    }
}
