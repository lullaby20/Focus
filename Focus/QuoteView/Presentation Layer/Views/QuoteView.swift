//
//  QuoteView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import SwiftUI

struct QuoteView: View {
    @ObservedObject var viewModel: QuoteViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Text(viewModel.text)
                .font(.system(size: 40, weight: .light))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(viewModel.author)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(.customGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 10) {
                Button {
                    viewModel.save()
                } label: {
                    Image(viewModel.isSaved ? .saveFill : .save)
                }

                Button {
                    viewModel.share()
                } label: {
                    Image(.share)
                }

            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .sheet(isPresented: $viewModel.showShareSheet) {
            ShareSheet(text: viewModel.shareText)
                .presentationDetents([.medium])
        }
    }
}
