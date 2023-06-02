//
//  Movie.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let release_date: String
    let poster_path: String?
    let overview: String
    var posterURL: URL? {
        if let path = poster_path {
            return URL(string: "\(Constants.POSTER_BASIC_URL)\(path)")
        }
        return nil
    }
    
    init(id: Int, title: String, release_date: String, poster_path: String?, overview: String) {
        self.id = id
        self.title = title
        self.release_date = release_date
        self.poster_path = poster_path
        self.overview = overview
    }
    
    init(cdMovie: CDMovie) {
        self.id = Int(cdMovie.id)
        self.title = cdMovie.title ?? ""
        self.release_date = cdMovie.release_date ?? ""
        self.poster_path = cdMovie.poster_path
        self.overview = cdMovie.overview ?? ""
    }
    
    static let mockData = Movie(
        id: 75780,
        title: "Jack Reacher",
        release_date: "2012-12-20",
        poster_path: "/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg",
        overview: "When a gunman takes five lives with six shots, all evidence points to the suspect in custody. On interrogation, the suspect offers up a single note: \"Get Jack Reacher!\" So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep."
    )
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
