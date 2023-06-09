//
//  NetworkService.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation
import CoreData

class RealNetworkService: NetworkService {
    private let session: URLSession
    private let apiKey: String
    private let persistenceController: PersistenceController
    
    init(session: URLSession = .shared, apiKey: String = Constants.MOVIE_API_KEY, persistenceController: PersistenceController = PersistenceController.shared) {
        self.session = session
        self.apiKey = apiKey
        self.persistenceController = persistenceController
    }
    
    func getSearchMovies(_ searchText: String, page: Int) async -> Result<SearchMovieAPIResponse, NetworkError> {
        guard let url = URL.getSearchMovies(apiKey, searchText: searchText, page: page) else { return  .failure(.badURL) }
        guard let (data, _) = try? await session.data(from: url) else { return .failure(.noData) }
        do {
            let searchMovieAPIResponse = try JSONDecoder().decode(SearchMovieAPIResponse.self, from: data)
            let backgroundContext = persistenceController.container.newBackgroundContext()
            for movie in searchMovieAPIResponse.results {
                persistenceController.add(movie, context: backgroundContext)
            }
            return .success(searchMovieAPIResponse)
        } catch {
            return .failure(.decodingError)
        }
    }
}
