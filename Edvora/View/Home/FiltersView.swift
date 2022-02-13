//
//  FiltersView.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/12.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject var viewModel: FiltersViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("FilterViewBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing:  0) {
                    Text(viewModel.title)
                        .foregroundColor(Color("FiltersTextColor"))
                    Color("Separator")
                        .opacity(0.5)
                        .frame(height: 1)
                        .padding(.top, 8)
                        .padding(.bottom, 30)
                    
                    VStack(alignment: .leading, spacing: 13) {
                        ForEach(viewModel.filterOptions, id: \.self) { option in
                            DropdownView(title: viewModel.dropdownTitle(for: option)) {
                                ScrollView {
                                    LazyVStack(spacing: 15) {
                                        ForEach(viewModel.displayableInfo(for: option), id: \.self) { value in
                                            HStack {
                                                Text(value)
                                                    .font(.body)
                                                    .fontWeight(.medium)
                                                Spacer()
                                                Image(systemName: "checkmark")
                                                    .font(.body)
                                                    .opacity(viewModel.isMenuSelected(for: option, value: value) ? 1 : 0)
                                            }
                                            .foregroundColor(Color("FiltersTextColor"))
                                            .padding(.leading, 8)
                                            .contentShape(Rectangle())
                                            .onTapGesture {
                                                viewModel.updateSelectedMenu(for: option, value: value)
                                            }
                                        }
                                    }
                                }
                                .frame(height: 100)
                                .padding(.top, 10)
                            }
                            .buttonStyle(FilterButtonStyle())
                        }                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button("Save") {
                        presentationMode.wrappedValue.dismiss()
                    }
            )
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
            .environmentObject(FiltersViewModel(products: Product.testProducts))
    }
}

struct FilterMenuStyle : MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding(12)
            .foregroundColor(.white)
            .background(
                Color("FilterBackground")
                    .cornerRadius(5)
            )
    }
}
