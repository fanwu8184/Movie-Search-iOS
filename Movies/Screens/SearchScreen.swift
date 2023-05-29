//
//  SearchScreen.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var movieAVM = MovieAVM()
    
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar { searchText in
                    Task {
                        await movieAVM.serachMovies(searchText)
                    }
                }
                .padding()
                
                List {
                    ForEach(movieAVM.movies, id: \.id) { movie in
                        Text(movie.title)
                    }
                }
                .modifier(ProgressViewModifier(isLoading: movieAVM.isLoading))
                .modifier(ErrorViewModifier(error: $movieAVM.error))
                .modifier(EmptyListViewModifier(isShowing: !movieAVM.isLoading && movieAVM.movies.isEmpty))
            }
            .navigationTitle("Movie Search")
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
