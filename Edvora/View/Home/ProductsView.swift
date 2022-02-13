//
//  ProductsView.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var viewModel: ProductsViewModel
    
    private var headerTitle: some View {
        Text(viewModel.title)
            .font(.system(size: 20))
            .fontWeight(.medium)
            .foregroundColor(.white)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerTitle
            Color("Separator")
                .opacity(0.5)
                .frame(height: 1)
                .padding(.top, 13)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.productCategory.products) { product in
                        ProductView(viewModel: .init(product: product))
                    }
                }
            }
            .padding(.top, 21)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(viewModel: .init(productCategory: .init(category: "Shoes", products: Product.testProducts)))
    }
}
