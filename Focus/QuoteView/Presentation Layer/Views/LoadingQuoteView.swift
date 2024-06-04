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
            RoundedRectangle(cornerRadius: 4)
                .fill(.skeletonGray)
                .frame(width: 333, height: 28)
                .redacted(reason: .placeholder)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(.skeletonGray)
                .frame(width: 250, height: 28)
                .redacted(reason: .placeholder)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(.skeletonGray)
                .frame(width: 280, height: 28)
                .redacted(reason: .placeholder)
                .padding(.bottom, 29)
            
            RoundedRectangle(cornerRadius: 6)
                .fill(.skeletonGray)
                .frame(width: 150, height: 20)
                .redacted(reason: .placeholder)
        }
    }
}
