//
//  CachedImageView.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/13/24.
//

import SwiftUI

struct CachedImageView: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String
    var body: some View {
        VStack{
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            loader.loadImage(from: urlString)
        }
        .onDisappear {
            loader.cancel()
        }
    }
}

#Preview {
    CachedImageView(urlString: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
