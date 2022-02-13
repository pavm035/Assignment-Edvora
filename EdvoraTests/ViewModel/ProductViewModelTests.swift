//
//  ProductViewModelTests.swift
//  EdvoraTests
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/13.
//

import XCTest
@testable import Edvora

class ProductViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProperties() {
        let viewModel = ProductViewModel(product: Product.testProducts.first!)
        XCTAssertEqual(viewModel.imageUrl, "https://test.image.com/1/png")
        XCTAssertEqual(viewModel.name, "Shoes")
        XCTAssertEqual(viewModel.brandName, "Adidas")
        XCTAssertEqual(viewModel.price, "100")
        XCTAssertEqual(viewModel.location, "Karnataka, Bengaluru")
        XCTAssertEqual(viewModel.date, "Date: 01:00:1970")
        XCTAssertEqual(viewModel.description, "Best item")
    }
}

