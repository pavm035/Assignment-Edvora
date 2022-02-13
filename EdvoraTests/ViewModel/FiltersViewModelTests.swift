//
//  FiltersViewModelTests.swift
//  EdvoraTests
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/13.
//

import XCTest
@testable import Edvora

class FiltersViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDefaultProperties() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        XCTAssertEqual(viewModel.title, "Filters")
        XCTAssertEqual(viewModel.displayableProducts.count, 2)
        XCTAssertEqual(viewModel.displayableStates.count, 1)
        XCTAssertEqual(viewModel.displayableCities.count, 1)
    }
    
    func testDefaultDropdownTitle() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        XCTAssertEqual(viewModel.dropdownTitle(for: .products), "Products")
        XCTAssertEqual(viewModel.dropdownTitle(for: .state), "State")
        XCTAssertEqual(viewModel.dropdownTitle(for: .city), "City")
    }
    
    func testDropdownTitleBySelection() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        viewModel.selectedProduct = "Shoes"
        XCTAssertEqual(viewModel.dropdownTitle(for: .products), "Shoes")
        viewModel.selectedState = "Karnataka"
        XCTAssertEqual(viewModel.dropdownTitle(for: .state), "Karnataka")
        viewModel.selectedCity = "Bengaluru"
        XCTAssertEqual(viewModel.dropdownTitle(for: .city), "Bengaluru")
    }
    
    func testMenuSelection() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        viewModel.updateSelectedMenu(for: .products, value: "Glass")
        XCTAssertEqual(viewModel.selectedProduct, "Glass")
        
        viewModel.updateSelectedMenu(for: .state, value: "Karnataka")
        XCTAssertEqual(viewModel.selectedState, "Karnataka")
        
        viewModel.updateSelectedMenu(for: .city, value: "Bengaluru")
        XCTAssertEqual(viewModel.selectedCity, "Bengaluru")
    }
    
    func testDisplayableInfo() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        XCTAssertEqual(viewModel.displayableInfo(for: .products).count, 2)
        XCTAssertEqual(viewModel.displayableInfo(for: .state).count, 1)
        XCTAssertEqual(viewModel.displayableInfo(for: .city).count, 1)
    }
    
    func testMenuSelectionByOption() throws {
        let viewModel = FiltersViewModel(products: Product.testProducts)
        viewModel.selectedProduct = "Shoes"
        XCTAssertTrue(viewModel.isMenuSelected(for: .products, value: "Shoes"))
        viewModel.selectedState = "Karnataka"
        XCTAssertTrue(viewModel.isMenuSelected(for: .state, value: "Karnataka"))
        viewModel.selectedCity = "Bengaluru"
        XCTAssertTrue(viewModel.isMenuSelected(for: .city, value: "Bengaluru"))
    }
}
