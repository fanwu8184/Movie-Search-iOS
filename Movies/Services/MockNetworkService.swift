//
//  MockNetworkService.swift
//  Movies
//
//  Created by Fan Wu on 6/2/23.
//

import Foundation

class MockNetworkService: NetworkService {
    var mockSearchMovieAPIResponse: Result<SearchMovieAPIResponse, NetworkError>?
    
    func getSearchMovies(_ searchText: String, page: Int) async -> Result<SearchMovieAPIResponse, NetworkError> {
        return .failure(.badURL)
    }
}
