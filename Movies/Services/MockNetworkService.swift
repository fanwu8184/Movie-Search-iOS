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
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        if let mockSearchMovieAPIResponse = mockSearchMovieAPIResponse {
            return mockSearchMovieAPIResponse
        }
        return .failure(.noData)
    }
}
