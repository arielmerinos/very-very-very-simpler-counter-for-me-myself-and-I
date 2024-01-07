//
//  Item.swift
//  Stepper
//
//  Created by Ariel Merino on 07/01/24.
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
