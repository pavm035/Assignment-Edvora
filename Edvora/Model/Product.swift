//
//  Product.swift
//  Edvora
//

//

import Foundation

struct Product: Decodable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case name = "product_name"
        case brandName = "brand_name"
        case price
        case address
        case description = "discription"
        case date
        case time
        case image
    }
    
    struct Address: Decodable, Hashable {
        let state: String
        let city: String
    }
    
    var id = UUID()
    let name: String
    let brandName: String
    let price: Int
    let address: Address
    let description: String
    let date: Date
    let time: Date
    let image: String
}


// MARK: Stubbign data
extension Product {
    static let testProducts: [Product] = {
        let p1 = Product(name: "Shoes", brandName: "Adidas", price: 100, address: .init(state: "Karnataka", city: "Bengaluru"), description: "Best item", date: Date(timeIntervalSince1970: 20), time: Date(), image: "https://test.image.com/1/png")
        let p2 = Product(name: "Sunglass", brandName: "Nike", price: 100, address: .init(state: "Karnataka", city: "Bengaluru"), description: "Best item", date: Date(timeIntervalSince1970: 20), time: Date(), image: "https://test.image.com/2/png")
        
        return [p1, p2]
    }()
}
