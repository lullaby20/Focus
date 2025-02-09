//
//  MainView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    let startDate = Date()
    
    var body: some View {
        TimelineView(.animation) { context in
            contentBody()
                .onAppear {
                    viewModel.getQuotes()
                }
                .background(
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .colorEffect(ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)))
                        .opacity(0.2)
                )
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
                ForEach(viewModel.quoteViewModels, id: \.self) { viewModel in
                    QuoteView(viewModel: viewModel)
                        .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                }
            }
            .scrollTargetLayout()
        }
        .ignoresSafeArea()
        .scrollTargetBehavior(.paging)
        .safeAreaInset(edge: .top) {
            logoView
        }
        .safeAreaInset(edge: .bottom) {
            tapForMoreView
        }
        .padding(.horizontal, 30)
        .sheet(isPresented: $viewModel.showCategoriesSheet) {
            CategoriesView(viewModel: viewModel.categoriesViewModel) { categories in
                viewModel.getQuotes(by: categories)
            }
            .presentationDetents([.large])
        }
    }
    
    var logoView: some View {
        Image(.logo)
            .padding(8)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
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
        .padding(8)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
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
