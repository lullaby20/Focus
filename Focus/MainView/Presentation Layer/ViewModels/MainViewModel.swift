//
//  MainViewModel.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    enum State {
        case loading
        case content
        case failure
    }
    
    private var quoteService: QuoteServiceProtocol
    private var cancellables: Set<AnyCancellable> = .init()
    private(set) var quoteViewModels: [QuoteViewModel] = []
    
    @Published var state: State = .loading
    
    init(quoteService: QuoteServiceProtocol) {
        self.quoteService = quoteService
    }
    
    func getQuotes() {
        self.state = .loading
        
        quoteService.getRandomQuotes()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                switch status {
                case .finished:
                    self.state = .content
                case .failure:
                    self.state = .failure
                }
            } receiveValue: { [weak self] quotes in
                guard let self else { return }
                self.quoteViewModels = quotes.map { QuoteViewModel(model: $0) }
            }
            .store(in: &cancellables)
    }
}
