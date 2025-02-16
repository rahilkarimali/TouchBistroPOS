//
//  ModelMock.swift
//  BillCalculation
//
//  Created by Rahil Karim Ali on 2025-02-14.
//

import Foundation
@testable import BillCalculation

struct Bill: BillProtocol {
    var taxes: [any TaxProtocol]?
    var discounts: [any DiscountProtocol]?
    var items: [any ItemProtocol]?
}

struct Item: ItemProtocol {
    var type: ItemType
    var price: Decimal
    var isTaxExempt: Bool
}

struct Tax: TaxProtocol {
    var percent: Decimal
    var isEnabled: Bool
    var type: TaxType
}

struct Discount: DiscountProtocol {
    var percent: Decimal?
    var amount: Decimal?
    var isEnabled: Bool
}
