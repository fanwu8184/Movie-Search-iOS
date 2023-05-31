//
//  PersistenceErrorExtension.swift
//  Movies
//
//  Created by Fan Wu on 5/31/23.
//

import Foundation

extension PersistenceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failSetup:
            return NSLocalizedString("Failed to set up Core Data.", comment: "Persistence Error")
        case .failSave:
            return NSLocalizedString("Failed to save data on your iPhone.", comment: "Persistence Error")
        }
    }
}
