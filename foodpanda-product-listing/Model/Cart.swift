//
//  Cart.swift
//  foodpanda-product-listing
//
//  Created by Apple on 22/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

class Cart: NSObject {
    var items : [CartItem] = []
}

extension Cart {
    var total: Float {
        get {
            return items.reduce(0.0) {
                value, item in
                value + item.subTotal
            }
        }
    }
    
    func updateCart(with product: Product) {
        if !self.contains(product: product) {
            self.addItem(product: product)
        } else {
            self.removeItem(product: product)
        }
    }
    
    func updateCart() {
        for item in self.items {
            if item.qty == 0 {
                updateCart(with: item.product)
            }
        }
    }
    
    var totalQty : Int {
           get { return items.reduce(0) { value, item in
               value + item.qty
               }
           }
       }
    
    
    func addItem(product: Product) {
        let item = items.filter { $0.product == product }
        
        if item.first != nil {
            item.first!.qty += 1
        } else {
            items.append(CartItem(product: product))
        }
    }
    
    func removeItem(product: Product) {
        guard let index = items.firstIndex(where: { $0.product == product }) else { return}
        items.remove(at: index)
    }
    
    func contains(product: Product) -> Bool {
        let item = items.filter { $0.product == product }
        return item.first != nil
    }
}
