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
    
    private var quoteService: QuoteServiceProtocol
    private var cancellables: Set<AnyCancellable> = .init()
    private(set) var categories: [CategoryModel] = []
    
    @Published var state: State = .loading
    
    init(quoteService: QuoteServiceProtocol) {
        self.quoteService = quoteService
    }
    
    func getCategories() {
        self.state = .loading
        
        quoteService.getCategories()
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
