//
//  CategoryModel.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import Foundation

struct CategoryModel: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

extension CategoryModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
