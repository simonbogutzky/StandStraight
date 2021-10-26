//
//  CustomModifier.swift
//  StandStraight
//
//  Created by Dr. Simon Bogutzky on 25.10.21.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.brandPrimary)
            .controlSize(.large)
    }
}
