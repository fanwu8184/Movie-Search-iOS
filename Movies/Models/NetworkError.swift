//
//  NetworkError.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}
