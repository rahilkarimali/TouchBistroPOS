//
//  Price.swift
//  BillCalc
//
//  Created by Rahil Karim Ali on 2025-02-14.
//  Copyright © 2025 TouchBistro. All rights reserved.
//

import Foundation

@propertyWrapper
struct Price {
    var wrappedValue: Decimal
    var projectedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: wrappedValue as NSNumber) ?? "0"
    }
}
