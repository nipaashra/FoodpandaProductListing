//
//  ViewController.swift
//  foodpanda-product-listing
//
//  Created by Shahin Gharebaghi on 27/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

enum ErrorMessageType{
    case stockAmount
    case maxOrder
    case equalstockandmaxvalue
    
    func getMessageError(limit:Int)-> String{
        switch self
        {
        case .stockAmount : return "Sorry! stock amount limit is \(limit) "
        case .maxOrder : return "Sorry! maximum order limit is \(limit)"
        case .equalstockandmaxvalue : return "Sorry! stock amount and maximum order limit is \(limit)"
        }
    }
}



class ViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnTotalPrice: CustomUIButton!
    fileprivate var products:[Product] = []
    fileprivate var cart: Cart? = nil
    var errorMsgType: ErrorMessageType = .stockAmount

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        products = ProductsListResponse().getAllProductsList()
        // User should not see the product with stock_amount equal to zero
        products = products.filter{$0.stockAmount != 0}

    }


}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        cell.delegate = self
        cell.btnLess.tag = indexPath.item
        cell.btnAdd.tag = indexPath.item
        cell.productsData = products[indexPath.row]
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2.0 - 20, height: 320)
    }
}


    
extension ViewController: ProductCartItemDelegate {
    
    // MARK: - CartItemDelegate
    func updateCartItem(indexRow: Int, qty: Int) {
        let product = products[indexRow]
        //====================================================================
        // User should not be able to add more than stock_amount
        // User should not be able to add more than max_per_order
        // stock_amout and max_per_order equal to -1 indicates there is no limitation for adding the product
        let limitQty = self.limitOrderCalculation(product: product, qty: qty)
        //====================================================================
        
        if(qty <= limitQty){
            let indexPath = IndexPath(item: indexRow, section: 0)
            if let cell:ProductsCollectionViewCell = (self.collectionView.cellForItem(at: indexPath) as? ProductsCollectionViewCell){
                cell.btnLess.isEnabled = qty > 0
                cell.btnQty.text = String(describing: qty)
            }
            
            if(cart == nil){
                cart = Cart()
            }
            
            if cart!.items.contains(where: {$0.product.id == product.id}){
                //Update cart item with product
                if let index = cart!.items.firstIndex(where: {$0.product.id == product.id}){
                    let cartItem = cart?.items[index]
                    cartItem?.qty = qty
                    guard let total = cart?.total else { return }
                    self.btnTotalPrice.setTitle(String(format: "Total price: $%.2f", total), for: .normal)
                }
            }else{
                //Add cart item with product
                cart?.updateCart(with: product)
                guard let total = cart?.total else { return }
                self.btnTotalPrice.setTitle(String(format: "Total price: $%.2f", total), for: .normal)
            }
            
        }else{
            // error message according to condition
            let msg = errorMsgType.getMessageError(limit: limitQty)
            self.showAlert(title: APPNAME, message: msg)
        }
      
    }
    
    func limitOrderCalculation(product:Product, qty:Int) -> Int{
        var limitQty: Int = 0
        if(product.stockAmount! != -1 && product.max_per_order! != -1){
            if(product.stockAmount! < product.max_per_order!){
                limitQty = product.stockAmount!
                errorMsgType = .stockAmount
            }else if(product.max_per_order! < product.stockAmount!){
                limitQty = product.max_per_order!
                errorMsgType = .maxOrder
            }else{
                limitQty = product.stockAmount!
                errorMsgType = .equalstockandmaxvalue
            }
        }else if(product.stockAmount! == -1 && product.max_per_order! != -1){
            limitQty = product.max_per_order!
            errorMsgType = .maxOrder
        }
        else if(product.max_per_order! == -1 && product.stockAmount! != -1){
            limitQty = product.stockAmount!
            errorMsgType = .stockAmount
        }else{
            limitQty = qty
        }
        return limitQty
    }
}
