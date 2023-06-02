//
//  MovieCellView.swift
//  Movies
//
//  Created by Fan Wu on 5/29/23.
//

import SwiftUI

struct MovieCellView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.title)
                .accessibilityIdentifier("MovieTitleText")
            
            Text(movie.release_date)
                .accessibilityIdentifier("MovieReleaseDateText")
            
            ImageInDiskCacheView(url: movie.posterURL)
                .frame(height: 500)
                .frame(maxWidth: .infinity)
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(movie: Movie.mockData)
    }
}
