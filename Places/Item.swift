//
//  Item.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
