//
//  HomeViewModel.swift
//  Edvora
//

//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    enum DisplayState {
        case loading
        case content
        case noData
    }
    
    private let dataProvider: ProductsAPIService
    private(set) var allProducts: [Product] = []
    private(set) var filtersViewModel = FiltersViewModel(products: [])
    
    //Group products by category
    @Published private(set) var productCategories: [ProductCategory] = []
    @Published private(set) var displayState: DisplayState = .loading
    @Published var clearFilters: Bool = false {
        didSet {
            if clearFilters {
                filtersViewModel.selectedProduct = nil
                filtersViewModel.selectedState = nil
                filtersViewModel.selectedCity = nil
                Task {
                    await updateDisplayableInfo()
                }
                objectWillChange.send()
            }
        }
    }
    
    var title: String {
        "Edvora"
    }
    
    var refreshTitle: String {
        "Refresh"
    }
        
    var loading: String {
        "Please wait..."
    }
    
    var noContentDescription: String {
        "Oops! No products to display reload again"
    }
    
    var shouldDisableClearFilter: Bool {
        filtersViewModel.selectedProduct == nil && filtersViewModel.selectedState == nil && filtersViewModel.selectedCity == nil
    }
    
    init(dataProvider: ProductsAPIService) {
        self.dataProvider = dataProvider
    }
}

// MARK: - Helper methods
extension HomeViewModel {
    func loadProducts() async {
        do {
            allProducts = try await dataProvider.fetchProducts()
            filtersViewModel.products = allProducts
            await updateDisplayableInfo()
        } catch {
            debugPrint("Load error:", error)
            await MainActor.run {
                displayState = .noData
            }
        }
    }
    
    func updateDisplayableInfo() async {
        await MainActor.run {
            var filterProducts = allProducts
            if let selectedProduct = filtersViewModel.selectedProduct {
                filterProducts = allProducts.filter { $0.name == selectedProduct }
            }
            
            if let selectedState = filtersViewModel.selectedState {
                filterProducts = filterProducts.filter { $0.address.state == selectedState }
            }
            
            if let selectedCity = filtersViewModel.selectedCity {
                filterProducts = filterProducts.filter { $0.address.city == selectedCity }
            }
            
            let productsInfo = Dictionary(grouping: filterProducts, by: \.name)
            productCategories = productsInfo.map { ProductCategory(category: $0.key, products: $0.value) }
            displayState = productCategories.isEmpty ? .noData : .content
        }
    }
}
