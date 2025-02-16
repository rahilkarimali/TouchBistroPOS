//
//  Tax.swift
//  BillCalc
//
//  Created by Rahil Karim Ali on 2025-02-13.
//  Copyright © 2025 TouchBistro. All rights reserved.
//

import Foundation
import BillCalculation

struct Tax: TaxProtocol {
    var label: String
    var percent: Decimal
    var isEnabled: Bool
    var type: TaxType
}
