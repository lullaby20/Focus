//
//  ShareSheet.swift
//  Focus
//
//  Created by Daniyar Merekeyev on 03.09.2024.
//

import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    var text: String
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityItems: [Any] = [text]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
