//
//  ProductViewModel.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import Foundation

class ProductViewModel: ObservableObject {
    private let product: Product
    
    private lazy var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:mm:yyyy"
        return dateFormatter
    }()
    
    var imageUrl: String {
        product.image
    }
    
    var name: String {
        product.name
    }
    
    var brandName: String {
        product.brandName
    }
    
    var price: String {
        "\(product.price)"
    }
    
    var location: String {
        "\(product.address.state), \(product.address.city)"
    }
    
    var date: String {
        "Date: \(dateFormatter.string(from: product.date))"
    }
    
    var description: String {
        product.description
    }
        
    init(product: Product) {
        self.product = product
    }
}
