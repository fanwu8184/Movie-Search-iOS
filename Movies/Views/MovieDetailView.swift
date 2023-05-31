//
//  MovieDetailView.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            MovieCellView(movie: movie)
            
            Text(movie.overview)
        }
        .padding()
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.mockData)
    }
}
