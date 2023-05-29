//
//  ProgressViewModifier.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation
import SwiftUI

struct ProgressViewModifier: ViewModifier {
    let isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isLoading {
                        ProgressView()
                    }
                }
            )
    }
}
