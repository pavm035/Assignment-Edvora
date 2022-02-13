//
//  ProductsViewModelTests.swift
//  EdvoraTests
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/13.
//

import XCTest
@testable import Edvora

class ProductsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() {
        let viewModel = ProductsViewModel(productCategory: .init(category: "Shoes", products: Product.testProducts))
        XCTAssertEqual(viewModel.title, "Shoes")
    }
}
