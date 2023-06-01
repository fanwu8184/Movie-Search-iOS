//
//  PersistenceError.swift
//  Movies
//
//  Created by Fan Wu on 5/31/23.
//

import Foundation

enum PersistenceError: Error {
    case failSetup
    case failSave
    case failGet
}
