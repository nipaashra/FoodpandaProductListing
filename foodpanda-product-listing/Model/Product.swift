//
//  Product.swift
//  foodpanda-product-listing
//
//  Created by Apple on 21/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

struct Product: Codable, Equatable {
    static var shared: [Product]?
    var id: Int
    var name: String
    var price: Float
    var image_url: String
    var stockAmount: Int
    var max_per_order: Int
}

extension Product {

}
