//
//  URLExtension.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

extension URL {
    static func getSearchMovies(_ searchText: String) -> URL? {
        return URL(string: "\(Constants.MOVIE_SEARCH_BASIC_URL)?api_key=\(Constants.MOVIE_API_KEY)&query=\(searchText.replacingOccurrences(of: " ", with: "+"))")
    }
}
