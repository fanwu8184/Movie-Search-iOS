//
//  MovieAM.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import Foundation

class MovieAVM: ObservableObject {
    @Published var movies = [Movie]()
    @Published var error: Error? = nil
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var totalPage = 1
    @Published var totalResults = 0
    private let networkService: NetworkService
    private var currentSearchText = ""
    var isShowingEmptyListInfo: Bool {
        movies.isEmpty && !isLoading && error == nil
    }

    init(_ networkService: NetworkService = RealNetworkService()) {
        self.networkService = networkService
    }
    
    @MainActor
    func initialSearchMovies(_ searchText: String) async {
        movies.removeAll()
        currentSearchText = searchText
        await searchMovies(searchText, searchPage: 1)
    }
    
    func searchMoviesForMore() async {
        await searchMovies(currentSearchText, searchPage: currentPage + 1)
    }
    
    @MainActor
    private func searchMovies(_ searchText: String, searchPage: Int) async {
        error = nil
        isLoading = true
        let result = await networkService.getSearchMovies(searchText, page: searchPage)
        switch result {
        case .success(let searchMovieAPIResponse):
            movies.append(contentsOf: searchMovieAPIResponse.results)
            currentPage = searchMovieAPIResponse.page
            totalPage = searchMovieAPIResponse.total_pages
            totalResults = searchMovieAPIResponse.total_results
        case .failure(let err):
            error = err
            let cdMovies = PersistenceController.shared.getMovies(searchText)
            movies = cdMovies.map { Movie(cdMovie: $0) }
            totalResults = movies.count
            currentPage = 1
            totalPage = 1
        }
        isLoading = false
    }
}
