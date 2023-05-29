//
//  NetworkService.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

class NetworkService {
    enum NetworkError: Error {
        case badURL
        case noData
        case decodingError
    }
    
    func getSearchMovies(_ searchText: String) async -> Result<SearchMovieAPIResponse, NetworkError> {
        guard let url = URL.getSearchMovies(searchText) else { return  .failure(.badURL) }
        guard let (data, _) = try? await URLSession.shared.data(from: url) else { return .failure(.noData) }
        guard let searchMovieAPIResponse = try? JSONDecoder().decode(SearchMovieAPIResponse.self, from: data) else { return .failure(.decodingError) }
        return .success(searchMovieAPIResponse)
    }
}
