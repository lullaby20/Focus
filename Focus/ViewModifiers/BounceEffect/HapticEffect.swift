//
//  HapticEffect.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 10.02.2025.
//

import SwiftUI

struct HapticEffect: ViewModifier {
    var style: UIImpactFeedbackGenerator.FeedbackStyle

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                TapGesture().onEnded {
                    let impact = UIImpactFeedbackGenerator(style: style)
                    impact.impactOccurred()
                }
            )
    }
}
