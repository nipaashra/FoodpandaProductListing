//
//  NAUIViewExtension.swift
//  foodpanda-product-listing
//
//  Created by Apple on 21/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
