//
//  MainView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 13.05.2024.
//

import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: MainViewModel
    let startDate: Date
    
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
            topView
        }
        .safeAreaInset(edge: .bottom) {
            tapForMoreButtonView
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
            .background(logoBackgroundColor, in: RoundedRectangle(cornerRadius: 12))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
    }
    
    var tapForMoreButtonView: some View {
        Button(action: {
            viewModel.openCategories()
        }, label: {
            Text("tap for more")
                .font(.system(size: 19, weight: .regular, design: .rounded))
                .foregroundColor(tapForMoreTextColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(tapForMoreBackgroundColor, in: RoundedRectangle(cornerRadius: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 8)
        })
    }
    
    var savedButtonView: some View {
        Button(action: {
            //
        }, label: {
            savedButtonIcon
                .padding(8)
                .background(savedButtonBackgroundColor, in: RoundedRectangle(cornerRadius: 12))
        })
    }
    
    var topView: some View {
        HStack(spacing: 8) {
            logoView
            
            Spacer()
            
            savedButtonView
        }
    }
    
    var loadingView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0..<5, id: \.self) { _ in
                    LoadingQuoteView()
                        .containerRelativeFrame(.vertical, count: 1, spacing: 0)
                }
            }
            .scrollTargetLayout()
        }
        .ignoresSafeArea()
        .scrollTargetBehavior(.paging)
        .safeAreaInset(edge: .top) {
            topView
        }
        .safeAreaInset(edge: .bottom) {
            tapForMoreButtonView
        }
        .padding(.horizontal, 30)
    }
}

// MARK: Computed Properties
fileprivate extension MainView {
    var logoBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : .white
    }
    
    var savedButtonIcon: Image {
        colorScheme == .dark ? Image(.saveFillWhite) : Image(.saveFillBlack)
    }
    
    var tapForMoreBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : .white
    }
    
    var tapForMoreTextColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var savedButtonBackgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray5) : .white
    }
}
