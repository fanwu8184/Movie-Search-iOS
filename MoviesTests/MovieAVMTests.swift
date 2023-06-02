//
//  MovieAVMTests.swift
//  MoviesTests
//
//  Created by Fan Wu on 6/2/23.
//

import XCTest
@testable import Movies

final class MovieAVMTests: XCTestCase {
    var movieAVM: MovieAVM!
    var networkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        networkService = MockNetworkService()
        movieAVM = MovieAVM(networkService)
    }
    
    override func tearDown() {
        movieAVM = nil
        networkService = nil
        super.tearDown()
    }
    
    func testInitialSearchMovies_Success() async {
        // Prepare
        let expectedMovies = [Movie(id: 1, title: "Movie 1", release_date: "2022-01-01", poster_path: nil, overview: "Overview 1")]
        let searchMovieAPIResponse = SearchMovieAPIResponse(page: 1, results: expectedMovies, total_pages: 1, total_results: 1)
        networkService.mockSearchMovieAPIResponse = .success(searchMovieAPIResponse)
        
        // Execute
        await movieAVM.initialSearchMovies("Test")
        
        // Assert
        XCTAssertEqual(movieAVM.movies, expectedMovies)
        XCTAssertNil(movieAVM.error)
        XCTAssertFalse(movieAVM.isLoading)
        XCTAssertEqual(movieAVM.currentPage, 1)
        XCTAssertEqual(movieAVM.totalPage, 1)
    }
    
    func testInitialSearchMovies_WhenNetworkRequestFails_ShouldSetError() async {
        // Arrange
        let expectedError = NetworkError.noData
        networkService.mockSearchMovieAPIResponse = .failure(expectedError)
        
        // Execute
        await movieAVM.initialSearchMovies("Test")
        
        // Assert
        XCTAssertTrue(movieAVM.movies.isEmpty)
        XCTAssertEqual(movieAVM.error as? NetworkError, expectedError)
    }
    
    func testInitialSearchMovies_WhenNetworkRequestSucceedsButEmptyResult_ShouldSetEmptyMovies() async {
        // Arrange
        let searchMovieAPIResponse = SearchMovieAPIResponse(page: 1, results: [], total_pages: 1, total_results: 0)
        networkService.mockSearchMovieAPIResponse = .success(searchMovieAPIResponse)
        
        // Execute
        await movieAVM.initialSearchMovies("Test")
        
        // Assert
        XCTAssertTrue(movieAVM.movies.isEmpty)
        XCTAssertNil(movieAVM.error)
    }
    
    func testSearchMoviesForMore_WhenMorePagesAvailable_ShouldAppendMovies() async {
        // Arrange
        let initialMovies = [
            Movie(id: 1, title: "Movie 1", release_date: "2022-01-01", poster_path: nil, overview: "Overview 1"),
            Movie(id: 2, title: "Movie 2", release_date: "2022-01-01", poster_path: nil, overview: "Overview 2")
        ]
        let nextPageMovies = [
            Movie(id: 3, title: "Movie 3", release_date: "2022-01-01", poster_path: nil, overview: "Overview 3"),
            Movie(id: 4, title: "Movie 4", release_date: "2022-01-01", poster_path: nil, overview: "Overview 4")
        ]
        movieAVM.movies = initialMovies
        
        let searchMovieAPIResponse = SearchMovieAPIResponse(page: 2, results: nextPageMovies, total_pages: 2, total_results: 4)
        networkService.mockSearchMovieAPIResponse = .success(searchMovieAPIResponse)
        
        // Execute
        await movieAVM.initialSearchMovies("Test")
        await movieAVM.searchMoviesForMore()
        
        // Assert
        XCTAssertEqual(movieAVM.currentPage, 2)
        XCTAssertEqual(movieAVM.movies.count, initialMovies.count + nextPageMovies.count)
        XCTAssertTrue(movieAVM.movies.contains(where: { $0.id == 3 }))
        XCTAssertTrue(movieAVM.movies.contains(where: { $0.id == 4 }))
    }
}
