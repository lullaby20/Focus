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
        guard let url = URL.getAPIURL(byPath: "/quotes") else { fatalError() }
        let urlRequest = URLRequest(url: url)

        return executeURLRequest(urlRequest)
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], any Error> {
        guard let url = URL.getAPIURL(byPath: "/tags") else { preconditionFailure() }
        let urlRequest = URLRequest(url: url)
        
        return executeURLRequest(urlRequest)
    }
}

// MARK: Execute URLRequest
fileprivate extension QuoteService {
    private func executeURLRequest<T>(_ urlRequest: URLRequest) -> AnyPublisher<T, Error> where T: Decodable {
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse,
                          httpResponse.statusCode == 200 else {
                    
                    #if DEBUG
                    print("Data = \(String(describing: result.data.prettyPrintedJSONString))")
                    #endif
                    
                    throw URLError(.badServerResponse)
                }
                
                #if DEBUG
                print("URLRequest = \(urlRequest)")
                print("Result - \(result)")
                print("Data = \(String(describing: result.data.prettyPrintedJSONString))")
                #endif
                
                return result.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
