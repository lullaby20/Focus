//
//  LoadingQuoteView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import SwiftUI

struct LoadingQuoteView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            SkeletonView(RoundedRectangle(cornerRadius: 8))
                .frame(width: 333, height: 28)
            
            SkeletonView(RoundedRectangle(cornerRadius: 8))
                .frame(width: 250, height: 28)
            
            SkeletonView(RoundedRectangle(cornerRadius: 8))
                .frame(width: 280, height: 28)
            
            SkeletonView(RoundedRectangle(cornerRadius: 8))
                .frame(width: 150, height: 25)
                .padding(.top, 30)
        }
    }
}
