//
//  ProductsViewModel.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import Foundation

class ProductsViewModel: ObservableObject {
    let productCategory: ProductCategory
    let productViewModels: [ProductViewModel]
    
    var title: String {
        productCategory.category
    }
    
    init(productCategory: ProductCategory) {
        self.productCategory = productCategory
        self.productViewModels = productCategory.products.map { ProductViewModel(product: $0) }
    }
}
