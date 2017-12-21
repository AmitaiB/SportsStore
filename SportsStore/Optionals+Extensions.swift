//
//  Optionals+Extensions.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/21/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import Foundation

extension Optional {
    var isSome: Bool { return self != nil }
    var isNone: Bool { return !isSome }
}
