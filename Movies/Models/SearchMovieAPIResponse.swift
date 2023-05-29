//
//  SearchMovieAPIResponse.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

struct SearchMovieAPIResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
