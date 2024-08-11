//
//  MainView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        contentBody()
            .onAppear {
                viewModel.getQuotes()
            }
    }
    
    @ViewBuilder
    private func contentBody() -> some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .content:
            contentView
        case .failure:
            EmptyView()
        }
    }
    
    var contentView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.quotes, id: \.self) { quote in
                    QuoteView(text: quote.quote, author: quote.author)
                        .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                }
            }
            .scrollTargetLayout()
        }
        .ignoresSafeArea()
        .scrollTargetBehavior(.paging)
        .overlay(alignment: .top) {
            logoView
        }
        .overlay(alignment: .bottom) {
            bottomBottomsView
        }
        .padding(.horizontal, 30)
    }
    
    var logoView: some View {
        Image(.logo)
            .frame(maxWidth: .infinity, alignment: .topLeading)
    }
    
    var bottomBottomsView: some View {
        HStack(spacing: 20) {
            Button(action: {
                //
            }, label: {
                Text("tap for more")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.customGray)
            })
            
            Spacer()
            
            Button(action: {
                //
            }, label: {
                Image(.save)
            })
            
            Button(action: {
                //
            }, label: {
                Image(.share)
            })
        }
    }
    
    var loadingView: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                logoView
                
                Spacer()
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        ForEach(0..<5, id: \.self) { _ in
                            LoadingQuoteView()
                                .frame(height: geometry.size.height * 0.91)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.paging)
                
                Spacer()
                
                bottomBottomsView
            }
            .padding(.horizontal, 30)
        }
    }
}
