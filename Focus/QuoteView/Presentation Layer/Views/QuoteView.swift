//
//  QuoteView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import SwiftUI

struct QuoteView: View {
    var text: String
    var author: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.system(size: 40, weight: .light))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("- " + author)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(.customGray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
