//
//  CartItem.swift
//  foodpanda-product-listing
//
//  Created by Apple on 22/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

class CartItem: NSObject {
    var qty : Int = 1
    var product : Product
    
    var subTotal : Float {
        get {
            return (product.price) * Float(qty)
        }
    }
    
    init(product: Product) {
        self.product = product
    }
}
