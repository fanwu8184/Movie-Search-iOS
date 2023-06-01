//
//  CacheImageView.swift
//  Movies
//
//  Created by Fan Wu on 6/1/23.
//

import SwiftUI

struct ImageInDiskCacheView: View {
    let url: URL?
    @State private var uiImage: UIImage? = nil
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView()
            }
            else if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
        }
        .task {
            guard let url = url else { return }
            let fileName = url.absoluteString.replacingOccurrences(of: "/", with: "_")
            if let data = MyFileManager.shared.get(fileName) {
                uiImage = UIImage(data: data)
            }
            else {
                isLoading = true
                guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
                isLoading = false
                MyFileManager.shared.save(fileName, data: data)
                uiImage = UIImage(data: data)
            }
        }
    }
}

struct ImageInDiskCacheView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInDiskCacheView(url: URL(string: "https://image.tmdb.org/t/p/w500/uQBbjrLVsUibWxNDGA4Czzo8lwz.jpg"))
    }
}
