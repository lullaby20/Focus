//
//  CategoriesViewModel.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import Foundation
import Combine

final class CategoriesViewModel: ObservableObject {
    enum State {
        case loading
        case content
        case failure
    }
    
    private var quoteRemoteDataSource: QuoteRemoteDataSourceProtocol
    private var cancellables: Set<AnyCancellable> = .init()
    private(set) var categories: [CategoryModel] = []
    var selectedCategories: [CategoryModel] = []
    
    @Published var state: State = .loading
    
    init(quoteRemoteDataSource: QuoteRemoteDataSourceProtocol) {
        self.quoteRemoteDataSource = quoteRemoteDataSource
    }
    
    func getCategories() {
        self.state = .loading
        
        quoteRemoteDataSource.getCategories()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .finished:
                    return
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] categories in
                guard let self else { return }
                self.categories = categories
            }
            .store(in: &cancellables)
    }
}
