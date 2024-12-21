//
//  RemoteImage.swift
//  WeatherTrackerApp
//
//  Created by Devangi Shah on 12/20/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        isLoading = true
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedImage in
                self?.image = loadedImage
                self?.isLoading = false
            }
    }

    deinit {
        cancellable?.cancel()
    }
}

struct RemoteImage: View {
    @StateObject private var loader = ImageLoader()
    var url: URL?

    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if loader.isLoading {
                ProgressView() // Placeholder while loading
            } else {
                // Optional fallback view when the image is not loaded and loading has stopped
                //Text("Image not available")
                Image(systemName: "person.fill")
                .foregroundColor(.gray)
            }
        }
        .onAppear {
            if let validURL = url {
                loader.loadImage(from: validURL)
            }
        }
    }
}
