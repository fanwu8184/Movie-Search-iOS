//
//  SearchBar.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search movies", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                Task {
                    let networkService = NetworkService()
                    let result = await networkService.getSearchMovies(text)
                    switch result {
                    case .success(let searchMovieAPIResponse):
                        print(searchMovieAPIResponse)
                    case .failure(let e):
                        print(e)
                    }
                }
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
        SearchBar(text: .constant(""))
    }
}
