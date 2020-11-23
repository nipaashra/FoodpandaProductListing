//
//  ProductsCollectionViewCell.swift
//  foodpanda-product-listing
//
//  Created by Apple on 21/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit
import SDWebImage


protocol ProductCartItemDelegate {
    func updateCartItem(indexRow: Int, qty: Int)
}

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnQty: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnLess: UIButton!
    var delegate: ProductCartItemDelegate?

    var qty: Int = 0
    
    var productsData:Product?{
           didSet{
            self.lblName.text = productsData?.name
            self.lblPrice.text = String(format: "%.2f", productsData?.price ?? "")
            let url = URL(string: productsData?.image_url ?? "")
            self.imgProduct.sd_setImage(with: url)
            self.imgProduct.contentMode = .scaleToFill
            self.btnLess.isEnabled = qty > 0
        }
    }

    override init(frame: CGRect) {
           super.init(frame: frame)
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
        delay(0.2) {
            self.setup()
        }
    }
    
    
    // MARK:-  Button Clicked Method
    @IBAction func btnLessClicked(_ sender: UIButton) {
        if qty > 0 {
            qty -= 1
        }
        self.delegate?.updateCartItem(indexRow: sender.tag, qty: qty)
    }
    
    @IBAction func btnAddClicked(_ sender: UIButton) {
        qty += 1
        self.delegate?.updateCartItem(indexRow: sender.tag, qty: qty)
    }
   
}

extension ProductsCollectionViewCell {
     func setup() {
        self.viewBox.layer.cornerRadius = 1.0
        self.viewBox.layer.borderColor = UIColor.black.cgColor
        self.viewBox.layer.borderWidth = 1.0
    }
}

