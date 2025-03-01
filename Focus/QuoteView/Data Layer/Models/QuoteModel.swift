//
//  QuoteModel.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 04.06.2024.
//

struct QuoteModel: Codable {
    let quote: String
    let author: String
    
    enum CodingKeys: String, CodingKey {
        case quote
        case author
    }
}

extension QuoteModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(quote)
        hasher.combine(author)
    }
}
