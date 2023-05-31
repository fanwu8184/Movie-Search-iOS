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
            
            Text(movie.release_date)
            
            CacheAsyncImage(
                url: movie.posterURL
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
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
