//
//  SearchBar.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct SearchBar: View {
    let searchAction: (String) -> ()
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            TextField("Search movies", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                searchAction(searchText)
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar { _ in }
    }
}
