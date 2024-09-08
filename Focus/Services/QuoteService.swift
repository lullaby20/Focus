//
//  QuoteService.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import Combine
import Foundation

protocol QuoteServiceProtocol {
    func getRandomQuotes() -> AnyPublisher<[QuoteModel], Error>
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

struct QuoteService: QuoteServiceProtocol {
    func getRandomQuotes() -> AnyPublisher<[QuoteModel], Error> {
        let url = URL.getAPIURL(byPath: "/quotes")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: [QuoteModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], any Error> {
//        let url = URL.getAPIURL(byPath: "/tags")!
        let url = URL(string: "https://api.quotable.io/tags")!
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: [CategoryModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
