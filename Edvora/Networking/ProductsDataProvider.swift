//
//  ProductsDataProvider.swift
//  Edvora
//

//

import Foundation

protocol ProductsAPIService {
    func fetchProducts() async throws -> [Product]
}

/// Data provider which performs API related operation related to Products
final class ProductsDataProvider: NetworkService, ProductsAPIService {
    
    /// Fetches list of available products from remote
    /// - Returns: list of products otherwise throws error
    func fetchProducts() async throws -> [Product] {
        let request = URLRequest(url: URL(string: "https://assessment-edvora.herokuapp.com/")!)
        return try await fetch(type: [Product].self, with: request)
    }
}
