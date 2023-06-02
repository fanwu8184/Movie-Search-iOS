//
//  SearchScreen.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var movieAVM = MovieAVM()
    @StateObject private var persistenceController = PersistenceController.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar { searchText in
                    hideKeyboard()
                    Task {
                        await movieAVM.initialSearchMovies(searchText)
                    }
                }
                .padding()
                
                if !movieAVM.movies.isEmpty {
                    Text("Results: \(movieAVM.movies.count)/\(movieAVM.totalResults)")
                }
                
                List {
                    ForEach(movieAVM.movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MovieCellView(movie: movie)
                        }
                    }
                    
                    if movieAVM.isLoading {
                        ProgressView()
                            .padding()
                    } else if movieAVM.currentPage < movieAVM.totalPage {
                        Button(action: {
                            Task {
                                await movieAVM.searchMoviesForMore()
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Load More")
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
                .modifier(ErrorViewModifier(error: $movieAVM.error))
                .modifier(EmptyListViewModifier(isShowing: movieAVM.isShowingEmptyListInfo))
                .modifier(ErrorViewModifier(error: $persistenceController.error))
                .accessibilityIdentifier("MovieList")
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
