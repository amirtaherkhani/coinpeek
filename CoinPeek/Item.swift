//
//  Item.swift
//  CoinPeek
//
//  Created by Amir on 09-05-1404.
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
