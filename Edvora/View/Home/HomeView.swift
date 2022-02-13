//
//  HomeView.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(dataProvider: ProductsDataProvider())
    @State private var isFiltersViewPresented = false
    
    private var productsView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.productCategories) { category in
                    ProductsView(viewModel: ProductsViewModel(productCategory: category))
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack(spacing: 20) {
            HomeToolBar(isFiltersViewPresented: $isFiltersViewPresented,
                        clearFilters: $viewModel.clearFilters,
                        shouldDisableClearFilter: viewModel.shouldDisableClearFilter)
                .padding(.top)
            productsView
                .padding(.leading, 8)
            Spacer()
        }
        .padding(.leading, 8)
    }
    
    private var noDataView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.icloud.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .foregroundColor(.white)
            Text(viewModel.noContentDescription)
                .font(.body)
                .foregroundColor(.white)
            Button {
                Task {
                    await viewModel.loadProducts()
                }
            } label: {
                Text(viewModel.refreshTitle)
                    .padding(12)
                    .foregroundColor(.white)
                    .background(
                        Color("FilterBackground")
                            .cornerRadius(5)
                    )
            }
        }
    }
    
    private var loadingView: some View {
        Text(viewModel.loading)
            .foregroundColor(.white)
            .font(.system(size: 20))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ThemeBackground")
                    .edgesIgnoringSafeArea(.all)
                
                switch viewModel.displayState {
                case .loading:
                    loadingView
                case .content:
                    contentView
                case .noData:
                    noDataView
                }
            }
            .navigationBarTitle(viewModel.title)
            .navigationBarTitleTextColor(Color.white.opacity(0.87))
            .sheet(isPresented: $isFiltersViewPresented) {
                Task {
                    await viewModel.updateDisplayableInfo()
                }
            } content: {
                FiltersView()
                    .environmentObject(viewModel.filtersViewModel)
            }
            .onAppear {
                Task {
                    await viewModel.loadProducts()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
