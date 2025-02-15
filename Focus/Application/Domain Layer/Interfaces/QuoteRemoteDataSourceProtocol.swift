//
//  QuoteRemoteDataSourceProtocol.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 15.02.2025.
//

import Combine

protocol QuoteRemoteDataSourceProtocol {
    func getRandomQuotes() -> AnyPublisher<[QuoteModel], Error>
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
}
