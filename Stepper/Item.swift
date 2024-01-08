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
	var steppercount: Int
    
	init(timestamp: Date, steppercount: Int) {
        self.timestamp = timestamp
		self.steppercount = steppercount
    }
}
