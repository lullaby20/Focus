//
//  CategoriesView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: CategoriesViewModel
    var onSelectCategories: (([CategoryModel]) -> Void)
    
    var body: some View {
        VStack(spacing: 8) {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category.name)
                        .onTapGesture {
                            if let index = viewModel.selectedCategories.firstIndex(of: category) {
                                viewModel.selectedCategories.remove(at: index)
                            } else {
                                viewModel.selectedCategories.append(category)
                            }
                        }
                }
            }
            
            Button {
                onSelectCategories(viewModel.selectedCategories)
            } label: {
                Text("Apply")
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
    }
}
