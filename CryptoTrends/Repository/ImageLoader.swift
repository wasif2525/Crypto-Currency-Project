//
//  ImageLoader.swift
//  CryptoTrends
//
//  Created by Bhuiyan Wasif on 12/13/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private static let imageCache = NSCache<NSURL, UIImage>()

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        // Check cache first
        if let cachedImage = ImageLoader.imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        // Download image if not cached
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let downloadedImage = downloadedImage else { return }
                // Cache the downloaded image
                ImageLoader.imageCache.setObject(downloadedImage, forKey: url as NSURL)
                self?.image = downloadedImage
            }
    }

    func cancel() {
        cancellable?.cancel()
    }
}

