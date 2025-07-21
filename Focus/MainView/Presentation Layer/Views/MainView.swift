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
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .colorEffect(ShaderLibrary.noise(.float(startDate.timeIntervalSinceNow)))
                .opacity(0.2)
                .overlay {
                    contentBodyView
                        .onAppear {
                            viewModel.getQuotes()
                        }
                        .safeAreaInset(edge: .top) {
                            topView
                        }
                        .safeAreaInset(edge: .bottom) {
                            tapForMoreButtonView
                        }
                        .padding(.horizontal, 24)
                        .sheet(isPresented: $viewModel.showCategoriesSheet) {
                            CategoriesView(viewModel: viewModel.categoriesViewModel) { categories in
                                viewModel.getQuotes(by: categories)
                            }
                            .presentationDetents([.large])
                        }
                }
        }
    }
    
    @ViewBuilder
    private var contentBodyView: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .content:
            contentView
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
    }
    
    var logoView: some View {
        Image(.logo)
            .padding(8)
            .background(logoBackgroundColor, in: RoundedRectangle(cornerRadius: 12))
            .frame(maxWidth: .infinity, alignment: .leading)
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
        .hapticEffect(style: .rigid)
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
        HStack {
            logoView
            
            Spacer()
            
            savedButtonView
        }
        .padding(.vertical, 8)
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
    }
}

// MARK: Computed Properties
fileprivate extension MainView {
    var logoBackgroundColor: Color {
        Color(colorScheme == .dark ? .systemGray5 : .white)
    }
    
    var savedButtonIcon: Image {
        Image(colorScheme == .dark ? .saveFillWhite : .saveFillBlack)
    }
    
    var tapForMoreBackgroundColor: Color {
        Color(colorScheme == .dark ? .systemGray5 : .white)
    }
    
    var tapForMoreTextColor: Color {
        Color(colorScheme == .dark ? .white : .black)
    }
    
    var savedButtonBackgroundColor: Color {
        Color(colorScheme == .dark ? .systemGray5 : .white)
    }
}

#Preview {
    let viewModel = MainViewModel(quoteRemoteDataSource: QuoteRemoteDataSource(network: Network()))
    MainView(viewModel: viewModel, startDate: Date())
}
