//
//  CategoriesView.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel: CategoriesViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.categories, id: \.self) { category in
                Text(category.name)
            }
        }
        .onAppear {
            viewModel.getCategories()
        }
    }
}
