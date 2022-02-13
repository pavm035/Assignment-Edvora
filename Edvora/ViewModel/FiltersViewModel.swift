//
//  FiltersViewModel.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/12.
//

import Foundation
import SwiftUI

class FiltersViewModel: ObservableObject {
    var products: [Product]
    
    @Published var selectedProduct: String? {
        willSet {
            if selectedProduct != newValue {
                selectedState = nil
                selectedCity = nil
            }
        }
        
        didSet {
            updateDisplayableInfo()
        }
    }
    
    @Published var selectedState: String?
    @Published var selectedCity: String?
    
    enum Option: CaseIterable {
        case products
        case state
        case city
                
        var title: String {
            switch self {
            case .products:
                return "Products"
            case .state:
                return "State"
            case .city:
                return "City"
            }
        }
    }
    
    let filterOptions = Option.allCases
    private(set) var displayableProducts: [String] = []
    private(set) var displayableStates: [String] = []
    private(set) var displayableCities: [String] = []
    var title: String {
        "Filters"
    }
    
    init(products: [Product]) {
        self.products = products
        updateDisplayableInfo()
    }
    
    func dropdownTitle(for option: Option) -> String {
        switch option {
        case .products:
            return selectedProduct ?? option.title
        case .state:
            return selectedState ?? option.title
        case .city:
            return selectedCity ?? option.title
        }
    }
    
    func updateSelectedMenu(for option: Option, value: String) {
        switch option {
        case .products:
            selectedProduct = value
        case .state:
            selectedState = value
        case .city:
            selectedCity = value
        }
    }
    
    func displayableInfo(for option: Option) -> [String] {
        switch option {
        case .products:
            return displayableProducts
        case .state:
            return displayableStates
        case .city:
            return displayableCities
        }
    }
    
    func isMenuSelected(for option: Option, value: String) -> Bool {
        switch option {
        case .products:
            return selectedProduct == value
        case .state:
            return selectedState == value
        case .city:
            return selectedCity == value
        }
    }
    
    private func updateDisplayableInfo() {
        products.forEach { product in
            displayableProducts.append(product.name)
            displayableStates.append(product.address.state)
            displayableCities.append(product.address.city)
        }
        
        displayableProducts = Set(displayableProducts).sorted()
        displayableStates = Set(displayableStates).sorted()
        displayableCities = Set(displayableCities).sorted()        
    }
}
