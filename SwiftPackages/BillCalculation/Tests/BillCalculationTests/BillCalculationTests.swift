import Testing
import Foundation
@testable import BillCalculation

@Test
func test_billCalculation_empty() async throws {
    let bill = Bill()
    #expect(bill.billTotalPostTaxAndDiscount == 0, "billTotalPostTaxAndDiscount should be 0 as there is no items in the bill")
    #expect(bill.billTotalPreTaxAndDiscount == 0, "billTotalPreTaxAndDiscount should be 0 as there is no items in the bill")
    #expect(bill.totalDiscountApplied == 0, "totalDiscountApplied should be 0 as there is no items in the bill")
    #expect(bill.totalTaxesApplied == 0, "totalTaxesApplied should be 0 as there is no items in the bill")
}

@Test
func test_billCalculation_emptyTax_emptyDiscount() async throws {
    var bill = Bill()
    let item = Item(type: .appetizers, price: 10, isTaxExempt: false)
    bill.items = [item]
    #expect(bill.billTotalPostTaxAndDiscount == 10, "billTotalPostTaxAndDiscount should be 10 as there is 1 items cost 10$, and no taxes and discount applied in the bill")
    #expect(bill.billTotalPreTaxAndDiscount == 10, "billTotalPreTaxAndDiscount should be 10 as there is 1 items cost 10$")
    #expect(bill.totalDiscountApplied == 0, "totalDiscountApplied should be 0 as there are no discount applied in the bill")
    #expect(bill.totalTaxesApplied == 0, "totalTaxesApplied should be 10 as there are no taxes and discount applied in the bill")
}

@Test
func test_billCalculation() async throws {
    var bill = Bill()
    
    bill.items = [
        Item(type: .appetizers, price: 10, isTaxExempt: true),
        Item(type: .appetizers, price: 11, isTaxExempt: false),
        Item(type: .mains, price: 12, isTaxExempt: true),
        Item(type: .mains, price: 13, isTaxExempt: false),
        Item(type: .drinks, price: 14, isTaxExempt: true),
        Item(type: .drinks, price: 15, isTaxExempt: false),
        Item(type: .alcohol, price: 16, isTaxExempt: true),
        Item(type: .alcohol, price: 17, isTaxExempt: false)
    ]
    
    bill.taxes = [
        Tax(percent: 0.05, isEnabled: false, type: .fedral),
        Tax(percent: 0.06, isEnabled: true, type: .fedral),
        Tax(percent: 0.07, isEnabled: false, type: .provincial),
        Tax(percent: 0.08, isEnabled: true, type: .provincial),
        Tax(percent: 0.09, isEnabled: false, type: .alcohol),
        Tax(percent: 0.10, isEnabled: true, type: .alcohol),
    ]
    
    bill.discounts = [
        Discount(percent: 0.05, isEnabled: true),
        Discount(percent: 0.15, isEnabled: false),
        Discount(amount: 5, isEnabled: true),
        Discount(amount: 10, isEnabled: false)
    ]
    
    #expect(bill.billTotalPostTaxAndDiscount == 106.663, "billTotalPostTaxAndDiscount should be 106.663 as there is 8 items cost 108$, and the taxes cost 9.5, and 10.877 discount is applied to the bill")
    #expect(bill.billTotalPreTaxAndDiscount == 108, "billTotalPreTaxAndDiscount should be 108 as there are 8 items cost 108$")
    #expect(bill.totalDiscountApplied == 10.877, "totalDiscountApplied should be 10.877 as there are 2 discounts  5$ and 5 % is applied to the bill")
    #expect(roundToTwoDecimalPlaces(bill.totalTaxesApplied) == roundToTwoDecimalPlaces(9.54), "totalTaxesApplied should be 10 as there is 1 items cost 10$, and the taxe is disabled, and no discount is applied to the bill")
}

func roundToTwoDecimalPlaces(_ value: Decimal) -> Decimal {
    let decimalValue = NSDecimalNumber(decimal: value)
    let roundedValue = decimalValue.rounding(accordingToBehavior: nil)
    return roundedValue.decimalValue
}
