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
        VStack(spacing: 0) {
            logoView
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.quoteViewModels, id: \.self) { viewModel in
                        QuoteView(viewModel: viewModel)
                            .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                    }
                }
                .scrollTargetLayout()
            }
            .ignoresSafeArea()
            .scrollTargetBehavior(.paging)
            
            tapForMoreView
        }
        .padding(.horizontal, 30)
        .sheet(isPresented: $viewModel.showCategoriesSheet) {
            CategoriesView(viewModel: viewModel.categoriesViewModel) { categories in
                viewModel.getQuotes(by: categories)
            }
            .presentationDetents([.medium, .large])
        }
    }
    
    var logoView: some View {
        Image(.logo)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
    }
    
    var tapForMoreView: some View {
        Button(action: {
            viewModel.openCategories()
        }, label: {
            Text("tap for more")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.customGray)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
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
                
                tapForMoreView
            }
            .padding(.horizontal, 30)
        }
    }
}
