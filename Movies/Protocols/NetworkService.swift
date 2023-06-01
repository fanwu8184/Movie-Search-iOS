//
//  NetworkService.swift
//  Movies
//
//  Created by Fan Wu on 6/2/23.
//

import Foundation

protocol NetworkService {
    func getSearchMovies(_ searchText: String, page: Int) async -> Result<SearchMovieAPIResponse, NetworkError>
}
