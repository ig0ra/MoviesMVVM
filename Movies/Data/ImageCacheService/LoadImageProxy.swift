// LoadImageProxy.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation

protocol LoadImageProtocol {
    func downloadImage(urlPath: String, completion: @escaping (Result<Data?, Error>) -> ())
}

/// Loading image sevice proxy
class LoadImageProxy: LoadImageProtocol {
    // MARK: - Private Properties

    private let imageAPIService: LoadImageProtocol
    private let cacheImageService: CacheImageServiceProtocol

    // MARK: - Initializators

    init(service: LoadImageProtocol, cacheImageService: CacheImageServiceProtocol) {
        imageAPIService = service
        self.cacheImageService = cacheImageService
    }

    // MARK: - Public Methods

    func downloadImage(urlPath: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let posterURLString = Constants.getPosterURLString(path: urlPath)

        if let imageData = cacheImageService.getImage(url: posterURLString) {
            completion(.success(imageData))
        } else {
            imageAPIService.downloadImage(urlPath: posterURLString) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    guard let data = data else { return }
                    self.cacheImageService.saveImage(url: posterURLString, imageData: data)
                    completion(.success(data))
                case .failure:
                    completion(.failure(CustomError.fetchedDataIsNil))
                }
            }
        }
    }
}
