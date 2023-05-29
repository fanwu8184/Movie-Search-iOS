//
//  ErrorViewModifier.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation
import SwiftUI

struct ErrorViewModifier: ViewModifier {
    @Binding var error: Error?
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if let err  = error {
                        VStack {
                            Text(err.localizedDescription)
                            
                            Button("Dismiss") {
                                error = nil
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
            )
    }
}
