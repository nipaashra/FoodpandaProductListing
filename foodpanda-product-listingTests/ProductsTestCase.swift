//
//  ProductsTestCase.swift
//  foodpanda-product-listingTests
//
//  Created by Apple on 23/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import XCTest
@testable import foodpanda_product_listing


class ProductsTestCase: XCTestCase {
    let products = ProductsListResponse().getAllProductsList().filter{$0.stockAmount != 0}
    
    func testProductNotShowingInList(){
        let result = products.contains(where: {$0.stockAmount == 0})
        XCTAssert(result == false)
    }

}
