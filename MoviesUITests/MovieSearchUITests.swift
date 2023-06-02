//
//  MovieSearchUITests.swift
//  MoviesUITests
//
//  Created by Fan Wu on 6/2/23.
//

import XCTest

final class MovieSearchUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testSearchMovies_DisplaySearchResults() {
        let searchText = "Jack"
        // Enter search query
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        searchTextField.typeText(searchText)
        
        // Tap Search button
        app.buttons["SearchButton"].tap()
        
        // Wait for search results
        let movieList = app.collectionViews["MovieList"]
        XCTAssertTrue(movieList.waitForExistence(timeout: 2))
        
        // Verify search results exist
        let firstMovieCellView = movieList.buttons.firstMatch
        XCTAssertTrue(firstMovieCellView.exists)
        
        // Verify movie details are displayed
        let movieTitleText = firstMovieCellView.staticTexts["MovieTitleText"]
        XCTAssertTrue(movieTitleText.label.lowercased().contains(searchText.lowercased()))
        
        let movieReleaseDateText = firstMovieCellView.staticTexts["MovieReleaseDateText"]
        XCTAssertTrue(movieReleaseDateText.exists)
        
        let moviePosterImage = firstMovieCellView.images.firstMatch
        XCTAssertTrue(moviePosterImage.waitForExistence(timeout: 2))
    }
    
    func testSearchMovies_TapOnSearchResult_ShouldShowMovieDetails() {
        let searchText = "Jack"
        // Enter search query
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        searchTextField.typeText(searchText)
        
        // Tap Search button
        app.buttons["SearchButton"].tap()
        
        // Wait for search results
        let movieList = app.collectionViews["MovieList"]
        XCTAssertTrue(movieList.waitForExistence(timeout: 2))
        
        // Verify search results exist
        let firstMovieCellView = movieList.buttons.firstMatch
        XCTAssertTrue(firstMovieCellView.exists)
        
        // Tap on first search result
        firstMovieCellView.tap()
        
        // Wait for movie details view
        let movieDetailView = app.scrollViews["MovieDetailView"]
        XCTAssertTrue(movieDetailView.waitForExistence(timeout: 1))
        
        // Verify movie details are displayed
        let movieTitleText = movieDetailView.staticTexts["MovieTitleText"]
        XCTAssertTrue(movieTitleText.label.lowercased().contains(searchText.lowercased()))

        let movieReleaseDateText = movieDetailView.staticTexts["MovieReleaseDateText"]
        XCTAssertTrue(movieReleaseDateText.exists)

        let moviePosterImage = movieDetailView.images.firstMatch
        XCTAssertTrue(moviePosterImage.waitForExistence(timeout: 2))
        
        let movieOverviewText = movieDetailView.staticTexts["MovieOverviewText"]
        XCTAssertTrue(movieOverviewText.exists)
    }
}
