//
//  Item.swift
//  BillCalc
//
//  Created by Rahil Karim Ali on 2025-02-13.
//  Copyright © 2025 TouchBistro. All rights reserved.
//

import Foundation
import BillCalculation

struct Item: ItemProtocol {
    var name: String
    var type: ItemType
    @Price var price: Decimal
    var isTaxExempt: Bool
    
    static func createAppetizer(name: String, price: Decimal, isTaxExempt: Bool = false) -> Item {
        Item(name: name, type: .appetizers, price: price, isTaxExempt: isTaxExempt)
    }
    
    static func createMain(name: String, price: Decimal, isTaxExempt: Bool = false) -> Item {
        Item(name: name, type: .mains, price: price, isTaxExempt: isTaxExempt)
    }
    
    static func createDrink(name: String, price: Decimal, isTaxExempt: Bool = false) -> Item {
        Item(name: name, type: .drinks, price: price, isTaxExempt: isTaxExempt)
    }
    
    static func createAlcohol(name: String, price: Decimal, isTaxExempt: Bool = false) -> Item {
        Item(name: name, type: .alcohol, price: price, isTaxExempt: isTaxExempt)
    }
}
