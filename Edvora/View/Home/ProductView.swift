//
//  ProductView.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    private var productInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.name)
                .fontWeight(.medium)
                .font(.system(size: 15))
            Text(viewModel.brandName)
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 13))
            Text("$ ")
                .font(.system(size: 16))
                .fontWeight(.medium) +
            Text(viewModel.price)
                .font(.system(size: 13))
        }
        .foregroundColor(.white)
    }
    
    private var footerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.location)
                Spacer()
                Text(viewModel.date)
            }
            .font(.system(size: 13))
            
            Text(viewModel.description)
                .font(.system(size: 11))
        }
        .foregroundColor(.white.opacity(0.7))
    }
    
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 20) {
                    AsyncImage(
                        url: URL(string: viewModel.imageUrl)!,
                        placeholder: { Color.gray.opacity(0.5) },
                        image: {
                            Image(uiImage: $0)
                                .resizable()
                        })
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    productInfoView
                }
                footerView
            }
            .padding(12)
            .background(
                Color.black
                    .cornerRadius(5)
            )
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: Product.testProducts.first!))
    }
}
