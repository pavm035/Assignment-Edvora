//
//  ProductsViewModel.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import Foundation

class ProductsViewModel: ObservableObject {
    let productCategory: ProductCategory
    
    var title: String {
        productCategory.category
    }
    
    init(productCategory: ProductCategory) {
        self.productCategory = productCategory
    }
}
