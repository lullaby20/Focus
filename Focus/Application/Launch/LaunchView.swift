//
//  LaunchView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 02.03.2025.
//

import SwiftUI

struct LaunchView: View {
    @State private var offset: CGFloat = 50
    @State private var opacity: Double = 0
    @State private var triggerHapticFeedback: Bool = false
    @Binding var showLaunchScreen: Bool
    let startDate: Date
    
    var body: some View {
        contentBodyView
    }
}

fileprivate extension LaunchView {
    var contentBodyView: some View {
        TimelineView(.animation) { context in
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .colorEffect(ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)))
                .opacity(0.2)
                .overlay {
                    overlayView
                }
        }
    }
    
    var overlayView: some View {
        VStack(spacing: 12) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text("Focus")
                .font(.system(size: 23, design: .rounded))
        }
        .offset(y: offset)
        .opacity(opacity)
        .onAppear {
            animateView()
        }
        .sensoryFeedback(.impact(weight: .heavy), trigger: triggerHapticFeedback)
    }
}

fileprivate extension LaunchView {
    func animateView() {
        withAnimation(.easeOut(duration: 1)) {
            offset = -15
            opacity = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            triggerHapticFeedback.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showLaunchScreen = false
            }
        }
    }
}
