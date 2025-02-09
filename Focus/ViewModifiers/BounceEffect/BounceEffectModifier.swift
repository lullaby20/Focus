//
//  BounceEffectModifier.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 09.02.2025.
//

import SwiftUI

struct BounceEffectModifier: ViewModifier {
    @State private var scale: CGFloat = 1.0

    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .animation(.interpolatingSpring(stiffness: 350, damping: 14), value: scale)
            .simultaneousGesture(
                TapGesture().onEnded { triggerBounceEffect() }
            )
    }

    private func triggerBounceEffect() {
        scale = 1.4
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            scale = 1.0
        }
    }
}
