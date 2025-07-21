//
//  SkeletonView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 21.07.2025.
//

import SwiftUI

struct SkeletonView<S: Shape>: View {
    var shape: S
    var color: Color
    
    @State private var isAnimating = false
    
    init(_ shape: S, color: Color = Color(.systemGray4)) {
        self.shape = shape
        self.color = color
    }
    
    var body: some View {
        contentView
    }
}

fileprivate extension SkeletonView {
    var contentView: some View {
        shape
            .fill(color)
            .overlay {
                overlay
            }
            .clipShape(shape)
            .compositingGroup()
            .onAppear {
                guard !isAnimating else { return }
                withAnimation(animation) {
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
            .transaction {
                if $0.animation != animation {
                    $0.animation = .none
                }
            }
    }
    
    var overlay: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let skeletonWidth = size.width / 2
            let blurRadius = max(skeletonWidth / 2, 30)
            let blurDiameter = blurRadius * 2
            let minX = -(skeletonWidth + blurDiameter)
            let maxX = size.width + skeletonWidth + blurDiameter
            
            Rectangle()
                .frame(width: skeletonWidth, height: size.height * 2)
                .frame(height: size.height)
                .blur(radius: blurRadius)
                .rotationEffect(.init(degrees: rotation))
                .blendMode(.softLight)
                .offset(x: isAnimating ? maxX : minX)
        }
    }
    
    var rotation: Double {
        5
    }
    
    var animation: Animation {
        .easeInOut(duration: 1.5)
        .repeatForever(autoreverses: false)
    }
}

#Preview {
    SkeletonView(RoundedRectangle(cornerRadius: 15))
        .frame(width: 250, height: 250)
}
