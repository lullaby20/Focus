//
//  QuoteRemoteDataSource.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

import Combine
import Foundation

struct QuoteRemoteDataSource {
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
}

extension QuoteRemoteDataSource: QuoteRemoteDataSourceProtocol {
    func getRandomQuotes() -> AnyPublisher<[QuoteModel], Error> {
        guard let url = URL.getAPIURL(byPath: "/quotes") else { fatalError() }
        let urlRequest = URLRequest(url: url)

        return network.executeURLRequest(urlRequest)
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], any Error> {
        guard let url = URL.getAPIURL(byPath: "/tags") else { preconditionFailure() }
        let urlRequest = URLRequest(url: url)
        
        return network.executeURLRequest(urlRequest)
    }
}
