//
//  HomeViewModelTests.swift
//  EdvoraTests
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/13.
//

import XCTest
@testable import Edvora

class HomeViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() {
        let viewModel = HomeViewModel(dataProvider: ProductsAPIServiceMock())
        XCTAssertEqual(viewModel.title, "Edvora")
        XCTAssertEqual(viewModel.refreshTitle, "Refresh")
        XCTAssertEqual(viewModel.loading, "Please wait...")
        XCTAssertEqual(viewModel.noContentDescription, "Oops! No products to display reload again")
        XCTAssertTrue(viewModel.shouldDisableClearFilter)
        XCTAssertEqual(viewModel.displayState, .loading)
    }
    
    func testProductsLoadFromRemote() async throws {
        let mock = ProductsAPIServiceMock()
        let viewModel = HomeViewModel(dataProvider: mock)
        await viewModel.loadProducts()
        XCTAssertEqual(viewModel.allProducts.count, 2)
        XCTAssertEqual(viewModel.productCategories.count, 2)
        XCTAssertEqual(viewModel.displayState, .content)
    }
    
    func testProductsLoadFailedDueToAPIError() async throws {
        let mock = ProductsAPIServiceMock()
        mock.errorToReturn = .invalidData
        let viewModel = HomeViewModel(dataProvider: mock)
        await viewModel.loadProducts()
        XCTAssertTrue(viewModel.allProducts.isEmpty)
        XCTAssertTrue(viewModel.productCategories.isEmpty)
        XCTAssertEqual(viewModel.displayState, .noData)
    }
    
    func testSelectedProductsShouldLoad() async throws {
        let mock = ProductsAPIServiceMock()
        let viewModel = HomeViewModel(dataProvider: mock)
        viewModel.filtersViewModel.selectedProduct = "Shoes"
        await viewModel.loadProducts()
        XCTAssertEqual(viewModel.allProducts.count, 2)
        XCTAssertEqual(viewModel.productCategories.count, 1)
        XCTAssertEqual(viewModel.displayState, .content)
    }
    
    func testProductsLoadWithClearFilter() async throws {
        let mock = ProductsAPIServiceMock()
        let viewModel = HomeViewModel(dataProvider: mock)
        viewModel.filtersViewModel.selectedProduct = "Shoes"
        await viewModel.loadProducts()
        XCTAssertEqual(viewModel.allProducts.count, 2)
        XCTAssertEqual(viewModel.productCategories.count, 1)
        XCTAssertEqual(viewModel.displayState, .content)
        
        // After clearing filter
        viewModel.clearFilters = true
        XCTAssertEqual(viewModel.allProducts.count, 2)
        XCTAssertEqual(viewModel.productCategories.count, 1)
        XCTAssertEqual(viewModel.displayState, .content)
    }
}

class ProductsAPIServiceMock: ProductsAPIService {
    var errorToReturn: APIError?
    var responseToReturn = Product.testProducts
    
    func fetchProducts() async throws -> [Product] {
        if let errorToReturn = errorToReturn {
            throw errorToReturn
        }
        
        return Product.testProducts
    }
}

