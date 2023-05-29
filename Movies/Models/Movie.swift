//
//  Movie.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let release_date: String
    let poster_path: String?
    let overview: String
}
