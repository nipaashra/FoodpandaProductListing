//
//  CartItemTestCase.swift
//  foodpanda-product-listingTests
//
//  Created by Apple on 23/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import XCTest
@testable import foodpanda_product_listing

class CartItemTestCase: XCTestCase {
    let cart = Cart()
    let products = ProductsListResponse().getAllProductsList().filter{$0.stockAmount != 0}
    var pizzaProd: Product { get { return products[0] } }
    var burgerProd: Product { get { return products[1] } }
    var boritoProd: Product { get { return products[2] } }
    var kebabProd: Product { get { return products[3] } }
    var chikenBriyaniProd: Product { get { return products[4] } }
    var fridChikenProd: Product { get { return products[5] } }

    
    
    func testCartIsEmpty() {
        XCTAssert(cart.total == 0)
        XCTAssertEqual(cart.totalQty, 0)
    }
    func testAddItemToCart(){
        //==================================================================
        // pizzaProd add Item to cart
        //Item add to cart
        cart.addItem(product: pizzaProd) //qty = 1
        XCTAssertEqual(cart.total, pizzaProd.price)
        
        cart.addItem(product: products[0])//qty = 2
        XCTAssert(cart.total == pizzaProd.price * 2)
        
        cart.addItem(product: burgerProd)//qty = 1
        cart.addItem(product: burgerProd)//qty = 2
        cart.addItem(product: burgerProd)//qty = 3
        XCTAssertEqual(cart.total, (burgerProd.price * 3) + (2 * pizzaProd.price), "total cart price is 3 qty of burger and 2 qty of pizza")
        //==================================================================
    }
    
    func testAddItemToCartToApplySomeCondition(){
        //==================================================================
        // pizzaProd add Item to cart
        //Item add to cart
        var qty:Int = 0
        qty += 1
        cart.addItem(product: pizzaProd)
        XCTAssertEqual(cart.total, pizzaProd.price, accuracy: 15.0)
        
        // As per data
        // stockAmount = 5 and max_per_order = 2 in pizzaProd
        //User should not be able to add more than stock_amount
        //User should not be able to add more than max_per_order
        //Stock_amout and max_per_order equal to -1 indicates there is no limitation for adding the product
        //add qty to cart for same item
        qty += 1
        let limitQty = limitOrderCalculation(product: pizzaProd, qty: qty)
        cart.addItem(product: products[0]) //Qty - 1
        XCTAssertLessThanOrEqual(qty,limitQty)
        //==================================================================
        
        // Stock_amout and max_per_order equal to -1 indicates there is no limitation for adding the product
        var qty1:Int = 0
        for i in 1..<20{
            qty1 = i
            //XCTAssertEqual success: for product chikenbiryani that stockAmount = -1  and max_order = -1
            let limitQty = limitOrderCalculation(product: chikenBriyaniProd, qty: qty1)
            XCTAssertEqual(qty1,limitQty)
            
            //XCTAssertEqual failed: for product burgerProd
            // stockAmount = 5 and // max_order = 7
//            let limitQty1 = limitOrderCalculation(product: burgerProd, qty: qty1)
//            XCTAssertEqual(qty1,limitQty1)
            
        }
        //==================================================================

    }
    
    func testCartQuantities() {
        
        cart.addItem(product: pizzaProd)
        cart.addItem(product: pizzaProd)
        XCTAssertEqual(cart.totalQty, 2, "2 items should contain in cart")
        
        cart.addItem(product: burgerProd)
        
        cart.addItem(product: kebabProd)
        cart.addItem(product: kebabProd)

        XCTAssertEqual(cart.totalQty, 5, "5 items should contain in cart")
    }
        
    
    func limitOrderCalculation(product:Product, qty:Int) -> Int{
        var limitQty: Int = 0
        if(product.stockAmount != -1 && product.max_per_order != -1){
            if(product.stockAmount < product.max_per_order){
                limitQty = product.stockAmount
            }else if(product.max_per_order < product.stockAmount){
                limitQty = product.max_per_order
            }else{
                limitQty = product.stockAmount
            }
        }else if(product.stockAmount == -1 && product.max_per_order != -1){
            limitQty = product.max_per_order
        }
        else if(product.max_per_order == -1 && product.stockAmount != -1){
            limitQty = product.stockAmount
        }else{
            limitQty = qty
        }
        return limitQty
    }
    

}
