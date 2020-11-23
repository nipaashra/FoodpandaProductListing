//
//  ProductsResponse.swift
//  foodpanda-product-listing
//
//  Created by Apple on 21/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation
import UIKit

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
                let alert = UIAlertController(title: APPNAME, message: "Unable to get product list \nPlease try again!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                let window = UIApplication.shared.windows.last
                window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        return products
    }
}



