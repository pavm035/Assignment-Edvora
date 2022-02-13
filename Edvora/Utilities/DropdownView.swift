//
//  DropdownVirew.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/12.
//

import SwiftUI

struct DropdownView<Content: View>: View {
    @State private var expand = false
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack {
            Button {
                withAnimation {
                    expand.toggle()
                }
            } label: {
                HStack(spacing: 40) {
                    Text(title)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .rotationEffect(expand ? .degrees(-180) : .degrees(0))
                }
            }
            
            if expand {
                content()
                    .simultaneousGesture (
                        TapGesture().onEnded { _ in
                            withAnimation {
                                expand.toggle()
                            }
                        }
                    )
            }
        }
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(title: "Expand") {
            ScrollView {
                ForEach(1..<20) { i in
                    Text("Row \(i)")
                }
            }
        }
        Spacer()
    }
}
