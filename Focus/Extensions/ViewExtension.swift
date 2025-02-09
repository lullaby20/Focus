//
//  ViewExtension.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 09.02.2025.
//

import SwiftUI

extension View {
    func bounceEffect() -> some View {
        self.modifier(BounceEffectModifier())
    }
    
    func hapticEffect(style: UIImpactFeedbackGenerator.FeedbackStyle) -> some View {
        self.modifier(HapticEffect(style: style))
    }
}
