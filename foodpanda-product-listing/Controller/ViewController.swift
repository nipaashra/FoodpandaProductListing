//
//  ViewController.swift
//  foodpanda-product-listing
//
//  Created by Shahin Gharebaghi on 27/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnTotalPrice: CustomUIButton!
    var products:[Product] = ProductsListResponse().getAllProductsList()
    var cart: Cart? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.collectionView!.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "ProductsCollectionViewCell")

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
//        let arr = cart?.items.filter{$0.product == product}
        if(cart != nil){
            if cart!.items.contains(where: {$0.product.id == product.id}){
                if let index = cart!.items.firstIndex(where: {$0.product.id == product.id}){
                    let cartItem = cart?.items[index]
                    cartItem?.qty = qty
                    guard let total = cart?.total else { return }
                    self.btnTotalPrice.setTitle(String(format: "Total price: $%.2f", total), for: .normal)
                }
            
               
            }else{
                cart?.updateCart(with: product)
                guard let total = cart?.total else { return }
                self.btnTotalPrice.setTitle(String(format: "Total price: $%.2f", total), for: .normal)
            }
        }else{
            cart = Cart()
            cart?.updateCart(with: product)
            guard let total = cart?.total else { return }
            self.btnTotalPrice.setTitle(String(format: "Total price: $%.2f", total), for: .normal)
        }
      
    }
    
}
