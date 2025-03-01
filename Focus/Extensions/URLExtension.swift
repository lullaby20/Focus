//
//  URLExtension.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import Foundation

extension URL {
    static func getAPIURL(byPath path: String) -> URL? {
        URL(string: "https://quoteslate.vercel.app/api" + path)
    }
}
