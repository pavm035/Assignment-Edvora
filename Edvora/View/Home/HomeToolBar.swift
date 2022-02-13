//
//  HomeToolBar.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/11.
//

import SwiftUI

struct HomeToolBar: View {
    @Binding var isFiltersViewPresented: Bool
    @Binding var clearFilters: Bool
    let shouldDisableClearFilter: Bool
    
    var body: some View {
        HStack {
            Button {
                isFiltersViewPresented = true
            } label: {
                HStack(spacing: 40) {
                    Text("Filters")
                    Image(systemName: "arrowtriangle.down.fill")
                }
            }
            .buttonStyle(FilterButtonStyle())
            
            Spacer()
            
            Button {
                clearFilters = true
            } label: {
                Text("Clear Filters")
            }
            .buttonStyle(FilterButtonStyle())
            .opacity(shouldDisableClearFilter ? 0.5 : 1)
            .disabled(shouldDisableClearFilter)
        }
        .padding(.horizontal, 10)
    }
}

struct HomeToolBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeToolBar(isFiltersViewPresented: .constant(false), clearFilters: .constant(false), shouldDisableClearFilter: false)
    }
}
