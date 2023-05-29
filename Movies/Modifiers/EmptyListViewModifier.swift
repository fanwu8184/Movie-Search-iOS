//
//  EmptyListViewModifier.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation
import SwiftUI

struct EmptyListViewModifier: ViewModifier {
    let isShowing: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isShowing {
                        Text("List Is Empty")
                    }
                }
            )
    }
}
