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
            
            AsyncImage(
                url: movie.posterURL
            ) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(height: 500)
            .frame(maxWidth: .infinity)
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(
            movie: Movie(
                id: 75780,
                title: "Jack Reacher",
                release_date: "2012-12-20",
                poster_path: "/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg",
                overview: "When a gunman takes five lives with six shots, all evidence points to the suspect in custody. On interrogation, the suspect offers up a single note: \"Get Jack Reacher!\" So begins an extraordinary chase for the truth, pitting Jack Reacher against an unexpected enemy, with a skill for violence and a secret to keep."
            )
        )
    }
}
