//
//  URLExtension.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

extension URL {
    static func getSearchMovies(_ apiKey: String, searchText: String, page: Int = 1) -> URL? {
        let searchBaseURl = "\(Constants.MOVIE_BASIC_URL)search/movie"
        let query = searchText.replacingOccurrences(of: " ", with: "+")
        return URL(string: "\(searchBaseURl)?api_key=\(apiKey)&query=\(query)&page=\(page)")
    }
}
