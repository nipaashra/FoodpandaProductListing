//
//  ProductsResponse.swift
//  foodpanda-product-listing
//
//  Created by Apple on 21/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

class ProductsListResponse {
    
    func getAllProductsList() -> [Product]{
        var products:[Product] = []
        if let path = Bundle.main.path(forResource: "Products", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                products = try! decoder.decode([Product].self, from: data)
            } catch {
                // handle error
            }
        }
        return products
    }

}


