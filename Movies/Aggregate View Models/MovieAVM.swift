//
//  MovieAM.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

class MovieAVM: ObservableObject {
    @Published var movies = [Movie]()
    @Published var error: Error? = nil
    @Published var isLoading = false
    private let networkService: NetworkService

    init(_ networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func serachMovies(_ searchText: String) async {
        movies = []
        error = nil
        isLoading = true
        let result = await networkService.getSearchMovies(searchText)
        switch result {
        case .success(let searchMovieAPIResponse):
            movies = searchMovieAPIResponse.results
        case .failure(let err):
            error = err
        }
        isLoading = false
    }
}
