//
//  Bill.swift
//  BillCalc
//
//  Created by Rahil Karim Ali on 2025-02-13.
//  Copyright © 2025 TouchBistro. All rights reserved.
//

import Foundation
import BillCalculation

struct Bill: BillProtocol {
    var taxes: [TaxProtocol]?    
    var discounts: [DiscountProtocol]?
    var items: [ItemProtocol]?
}
