//
//  NetworkErrorExtension.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("A bad URL error. Please contact our team.", comment: "Network Error")
        case .noData:
            return NSLocalizedString("A network error, please try later.", comment: "Network Error")
        case .decodingError:
            return NSLocalizedString("A decoding error. Please contact our team.", comment: "Network Error")
        }
    }
}
