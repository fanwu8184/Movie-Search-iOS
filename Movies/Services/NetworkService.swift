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
        case decodingError
    }
    
    private let session: URLSession
    private let apiKey: String
    
    init(session: URLSession = .shared, apiKey: String = Constants.MOVIE_API_KEY) {
        self.session = session
        self.apiKey = apiKey
    }
    
    func getSearchMovies(_ searchText: String) async -> Result<SearchMovieAPIResponse, NetworkError> {
        guard let url = URL.getSearchMovies(apiKey, searchText: searchText) else { return  .failure(.badURL) }
        do {
            let (data, _) = try await session.data(from: url)
            let searchMovieAPIResponse = try JSONDecoder().decode(SearchMovieAPIResponse.self, from: data)
            return .success(searchMovieAPIResponse)
        } catch {
            return .failure(.decodingError)
        }
    }
}
