//
//  URLExtension.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import Foundation

extension URL {
    static func getAPIURL(byPath path: String) -> URL? {
        URL(string: "https://zenquotes.io/api" + path)
    }
}
