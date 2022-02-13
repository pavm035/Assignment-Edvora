//
//  ProductsCategory.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import Foundation

struct ProductCategory: Identifiable, Hashable {
    var id = UUID()
    let category: String
    let products: [Product]
}
