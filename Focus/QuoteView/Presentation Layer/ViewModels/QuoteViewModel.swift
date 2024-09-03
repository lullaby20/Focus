//
//  QuoteViewModel.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 31.08.2024.
//

import Foundation
import Combine

final class QuoteViewModel: ObservableObject {
    private var model: QuoteModel?
    
    @Published var isSaved: Bool = false
    @Published var showShareSheet: Bool = false
    
    var text: String {
        model?.quote ?? ""
    }
    
    var author: String {
        "- " + (model?.author ?? "")
    }
    
    var shareText: String {
        "Hey, look what i have found in Focus app!" + (model?.quote ?? "") + "\n- " + (model?.author ?? "")
    }
    
    init(model: QuoteModel) {
        self.model = model
    }
    
    func save() {
        isSaved.toggle()
    }
    
    func share() {
        showShareSheet.toggle()
    }
}

extension QuoteViewModel: Hashable {
    static func == (lhs: QuoteViewModel, rhs: QuoteViewModel) -> Bool {
        lhs.model == rhs.model
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(model)
    }
}
