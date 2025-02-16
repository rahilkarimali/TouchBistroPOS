//
//  RegisterViewModelUnitTest.swift
//  POSTests
//
//  Created by Rahil Karim Ali on 2025-02-16.
//  Copyright © 2025 TouchBistro. All rights reserved.
//

import Testing
import Foundation
@testable import POS

struct RegisterViewModelUnitTest {
    var viewModel: RegisterViewModel
        
    let orderItems = [
        Item.createAppetizer(name: "Nachos", price: 9.99),
        Item.createMain(name: "Burger", price: 10.99),
        Item.createDrink(name: "Water", price: 11.99),
        Item.createAlcohol(name: "Beer", price: 12.99)
    ]
    
    init() {
        viewModel = RegisterViewModel(orderItems: orderItems, categories: categories)
    }
            
    @Test
    func test_init_propertiesAreSetCorrectly() async throws {
        let viewModelTest = RegisterViewModel(categories: categories)
        #expect(viewModelTest.categories.count == 4)
        #expect(viewModelTest.orderItems.count == 0)
        
        #expect(viewModel.categories.count == 4)
        #expect(viewModel.orderItems.count == 4)
    }

    @Test
    func test_menuCategoryTitle() async throws {
        #expect(viewModel.menuCategoryTitle(in: 0) == "Appetizers")
        #expect(viewModel.menuCategoryTitle(in: 1) == "Mains")
        #expect(viewModel.menuCategoryTitle(in: 2) == "Drinks")
        #expect(viewModel.menuCategoryTitle(in: 3) == "Alcohol")
    }

    @Test
    func test_orderTitle() async throws {
        #expect(viewModel.orderTitle(in: 0) == "Bill")
    }
    
    @Test
    func test_numberOfMenuCategories() async throws {
        #expect(viewModel.numberOfMenuCategories() == 4)
    }
    
    @Test
    func test_numberOfMenuItems() async throws {
        #expect(viewModel.numberOfMenuItems(in: 0) == 3)
        #expect(viewModel.numberOfMenuItems(in: 1) == 3)
        #expect(viewModel.numberOfMenuItems(in: 2) == 3)
        #expect(viewModel.numberOfMenuItems(in: 3) == 3)
    }
    
    @Test
    func test_numberOfOrderItems() async throws {
        #expect(viewModel.numberOfOrderItems(in: 0) == 4)
    }
    
    @Test
    func test_menuItemName() async throws {
        #expect(viewModel.menuItemName(at: IndexPath(row: 0, section: 0)) == "Nachos")
        #expect(viewModel.menuItemName(at: IndexPath(row: 0, section: 1)) == "Burger")
        #expect(viewModel.menuItemName(at: IndexPath(row: 0, section: 2)) == "Water")
        #expect(viewModel.menuItemName(at: IndexPath(row: 0, section: 3)) == "Beer")
        #expect(viewModel.menuItemName(at: IndexPath(row: 1, section: 0)) == "Calamari")
        #expect(viewModel.menuItemName(at: IndexPath(row: 1, section: 1)) == "Hotdog")
        #expect(viewModel.menuItemName(at: IndexPath(row: 1, section: 2)) == "Pop")
        #expect(viewModel.menuItemName(at: IndexPath(row: 1, section: 3)) == "Cider")
        #expect(viewModel.menuItemName(at: IndexPath(row: 2, section: 0)) == "Caesar Salad")
        #expect(viewModel.menuItemName(at: IndexPath(row: 2, section: 1)) == "Pizza")
        #expect(viewModel.menuItemName(at: IndexPath(row: 2, section: 2)) == "Orange Juice")
        #expect(viewModel.menuItemName(at: IndexPath(row: 2, section: 3)) == "Wine")
    }
    
    @Test
    func test_menuItemPrice() async throws {
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 0, section: 0)) == "$13.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 0, section: 1)) == "$9.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 0, section: 2)) == "$0.00")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 0, section: 3)) == "$5.00")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 1, section: 0)) == "$11.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 1, section: 1)) == "$3.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 1, section: 2)) == "$2.00")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 1, section: 3)) == "$6.00")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 2, section: 0)) == "$10.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 2, section: 1)) == "$12.99")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 2, section: 2)) == "$3.00")
        #expect(viewModel.menuItemPrice(at: IndexPath(row: 2, section: 3)) == "$7.00")
    }
        
    @Test
    func test_labelForOrderItem() async throws {
        let indexPath = IndexPath(row: 0, section: 0)
        #expect(viewModel.labelForOrderItem(at: indexPath) == "Nachos")
        viewModel.orderItems[indexPath.row].isTaxExempt = true
        #expect(viewModel.labelForOrderItem(at: indexPath) == "Nachos (No Tax)")
    }
    
    @Test
    func test_orderItemPrice() async throws {
        #expect(viewModel.orderItemPrice(at: IndexPath(row: 0, section: 0)) == "$9.99")
        #expect(viewModel.orderItemPrice(at: IndexPath(row: 1, section: 0)) == "$10.99")
        #expect(viewModel.orderItemPrice(at: IndexPath(row: 2, section: 0)) == "$11.99")
        #expect(viewModel.orderItemPrice(at: IndexPath(row: 3, section: 0)) == "$12.99")
    }
    
    @Test
    func test_addItemToOrder() async throws {
        #expect(viewModel.orderItems.count == 4)
        let indexPath = viewModel.addItemToOrder(at: IndexPath(row: 0, section: 0))
        #expect(indexPath == IndexPath(row: 4, section: 0))
        #expect(viewModel.orderItems[indexPath.row].name == "Nachos")
        #expect(viewModel.orderItems.count == 5)
    }
    
    @Test
    func test_removeItemFromOrder() async throws {
        #expect(viewModel.orderItems.count == 4)
        viewModel.removeItemFromOrder(at: IndexPath(row: 0, section: 0))
        #expect(viewModel.orderItems.count == 3)
    }
    
    @Test
    func test_toggleTaxForOrderItem() async throws {
        let indexPath = IndexPath(row: 0, section: 0)
        viewModel.orderItems[indexPath.row].isTaxExempt = false
        
        #expect(viewModel.orderItems[indexPath.row].isTaxExempt == false)
        viewModel.toggleTaxForOrderItem(at: indexPath)
        #expect(viewModel.orderItems[indexPath.row].isTaxExempt == true)
        
        #expect(viewModel.orderItems[indexPath.row].isTaxExempt == true)
        viewModel.toggleTaxForOrderItem(at: indexPath)
        #expect(viewModel.orderItems[indexPath.row].isTaxExempt == false)
    }
}
