//
//  FilterButtonStyle.swift
//  Edvora
//
//  Created by Mahadevaiah, Pavan | Pavan | ECMPD on 2022/02/12.
//

import SwiftUI

/// Custom button style for filter buttons
struct FilterButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(.white)
            .background(
                Color("FilterBackground")
                    .cornerRadius(5)
            )
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
