//
//  Menu.swift
//  POS
//
//  Created by Tayson Nguyen on 2019-04-23.
//  Copyright © 2019 TouchBistro. All rights reserved.
//

import Foundation

let appetizersCategory = [
    Item.createAppetizer(name: "Nachos", price: 13.99),
    Item.createAppetizer(name: "Calamari", price: 11.99),
    Item.createAppetizer(name: "Caesar Salad", price: 10.99)
]

let mainsCategory = [
    Item.createMain(name: "Burger", price: 9.99),
    Item.createMain(name: "Hotdog", price: 3.99),
    Item.createMain(name: "Pizza", price: 12.99),
]

let drinksCategory = [
    Item.createDrink(name: "Water", price: 0),
    Item.createDrink(name: "Pop", price: 2.00),
    Item.createDrink(name: "Orange Juice", price: 3.00),
]

let alcoholCategory = [
    Item.createAlcohol(name: "Beer", price: 5.00),
    Item.createAlcohol(name: "Cider", price: 6.00),
    Item.createAlcohol(name: "Wine", price: 7.00),
]

var taxes = [
    Tax(label: "Tax 1 (5%)", percent: 0.05, isEnabled: true, type: .fedral),
    Tax(label: "Tax 2 (8%)", percent: 0.08, isEnabled: true, type: .provincial),
    Tax(label: "Alcohol Tax (10%)", percent: 0.10, isEnabled: true, type: .alcohol),
] {
    didSet {
        NotificationCenter.default.post(name: .taxesDidChange, object: taxes)
    }
}

var discounts = [
    Discount(label: "$5.00", amount: 5.00, isEnabled: false),
    Discount(label: "10%", percent: 0.10, isEnabled: false),
    Discount(label: "20%", percent: 0.20, isEnabled: false),
] {
    didSet {
        NotificationCenter.default.post(name: .discountDidChange, object: discounts)
    }
}

var categories = [
    Category(name: "Appetizers", items: appetizersCategory),
    Category(name: "Mains", items: mainsCategory),
    Category(name: "Drinks", items: drinksCategory),
    Category(name: "Alcohol", items: alcoholCategory),
]

