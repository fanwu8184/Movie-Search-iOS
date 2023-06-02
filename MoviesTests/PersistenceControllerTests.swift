//
//  PersistenceControllerTests.swift
//  MoviesTests
//
//  Created by Fan Wu on 6/2/23.
//

import XCTest
import CoreData
@testable import Movies

final class PersistenceControllerTests: XCTestCase {
    var persistenceController: PersistenceController!
    
    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController()
    }
    
    override func tearDown() {
        persistenceController = nil
        super.tearDown()
    }

    func testAddMovie_ShouldSaveMovieToContext() {
        // Arrange
        let movie = Movie(id: 1, title: "Test Movie", release_date: "2022-01-01", poster_path: nil, overview: "Test overview")
        let context = persistenceController.mainContext
        
        // Execute
        persistenceController.add(movie, context: context)
        
        // Assert
        let fetchRequest: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
        do {
            let cdMovies = try context.fetch(fetchRequest)
            XCTAssertEqual(cdMovies.count, 1)
            let cdMovie = cdMovies.first
            XCTAssertEqual(cdMovie?.id, Int32(movie.id))
            XCTAssertEqual(cdMovie?.title, movie.title)
            XCTAssertEqual(cdMovie?.release_date, movie.release_date)
            XCTAssertEqual(cdMovie?.poster_path, movie.poster_path)
            XCTAssertEqual(cdMovie?.overview, movie.overview)
        } catch {
            XCTFail("Failed to fetch movies from context: \(error.localizedDescription)")
        }
    }
    
    func testGetMovies_WithValidTitle_ShouldReturnMatchingMovies() {
        // Arrange
        let movie1 = Movie(id: 1, title: "Test Movie 1", release_date: "2022-01-01", poster_path: nil, overview: "Test overview 1")
        let movie2 = Movie(id: 2, title: "Test Movie 2", release_date: "2022-01-01", poster_path: nil, overview: "Test overview 2")
        let context = persistenceController.mainContext
        persistenceController.add(movie1, context: context)
        persistenceController.add(movie2, context: context)
        
        // Execute
        let movies = persistenceController.getMovies("Test Movie")
        
        // Assert
        XCTAssertEqual(movies.count, 2)
        XCTAssertTrue(movies.contains { $0.title == movie1.title })
        XCTAssertTrue(movies.contains { $0.title == movie2.title })
    }
    
    func testGetMovies_WithInvalidTitle_ShouldReturnEmptyArray() {
        // Arrange
        let movie1 = Movie(id: 1, title: "Test Movie 1", release_date: "2022-01-01", poster_path: nil, overview: "Test overview 1")
        let movie2 = Movie(id: 2, title: "Test Movie 2", release_date: "2022-01-01", poster_path: nil, overview: "Test overview 2")
        let context = persistenceController.mainContext
        persistenceController.add(movie1, context: context)
        persistenceController.add(movie2, context: context)
        
        // Execute
        let movies = persistenceController.getMovies("Nonexistent Movie")
        
        // Assert
        XCTAssertTrue(movies.isEmpty)
    }
}
