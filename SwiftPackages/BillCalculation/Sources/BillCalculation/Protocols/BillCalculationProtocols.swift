//
//  File.swift
//  BillCalculation
//
//  Created by Rahil Karim Ali on 2025-02-13.
//

import Foundation

public enum ItemType {
    case appetizers, mains, drinks, alcohol
}

public enum TaxType {
    case provincial, fedral, alcohol
}

public protocol BillProtocol {
    var taxes: [TaxProtocol]? { get set }
    var discounts: [DiscountProtocol]? { get set }
    var items: [ItemProtocol]? { get set }    
}

public protocol ItemProtocol {
    var type: ItemType { get set }
    var price: Decimal { get set }
    var isTaxExempt: Bool { get set }
}

public protocol TaxProtocol {
    var percent: Decimal { get set }
    var isEnabled: Bool { get set }
    var type: TaxType { get set }
}

public protocol DiscountProtocol {
    var percent: Decimal? { get set }
    var amount: Decimal? { get set }
    var isEnabled: Bool { get set }
}

public extension BillProtocol {
    var billTotalPreTaxAndDiscount: Decimal {
        items?.map{ $0.price }.reduce(0, +) ?? 0
    }
    
    var billTotalPostTaxAndDiscount: Decimal {
        billTotalPreTaxAndDiscount + totalTaxesApplied - totalDiscountApplied
    }

    var totalTaxesApplied: Decimal {
        let taxableAmount = items?.filter { !$0.isTaxExempt }.map{ $0.price }.reduce(0, +) ?? 0
        let additionalAlcoholAmount = items?.filter { !$0.isTaxExempt && $0.type == .alcohol }.map{ $0.price }.reduce(0, +) ?? 0
        
        let tax = taxes?.filter({ $0.isEnabled && $0.type != .alcohol}).map{ $0.percent }.reduce(0, +) ?? 0
        let alcoholTax = taxes?.filter({ ($0.isEnabled && $0.type == .alcohol) }).map{ $0.percent }.reduce(0, +) ?? 0
        
        return (taxableAmount * tax ) + (additionalAlcoholAmount * alcoholTax)
    }
    
    var totalDiscountApplied: Decimal {
        let billPreDiscount = billTotalPreTaxAndDiscount + totalTaxesApplied
        var billPostDiscount = billPreDiscount
        guard let discounts = discounts else  { return 0 }
        
        for discount in discounts.filter({ $0.isEnabled }) {
            if let discountAmount = discount.amount {
                billPostDiscount -= discountAmount
            } else if let discountPercentage = discount.percent {
                billPostDiscount = billPostDiscount * (1 - discountPercentage)
            }
        }
        let discount = billPreDiscount - billPostDiscount
        
        return discount > billPreDiscount ? billPreDiscount : discount
    }
}
