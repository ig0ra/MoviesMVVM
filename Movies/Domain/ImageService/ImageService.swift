// ImageService.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation
import UIKit

protocol ImageServiceProtocol {
    func getImage(urlPath: String, completion: @escaping (UIImage?) -> ())
}

final class ImageService: ImageServiceProtocol {
    // MARK: - Private Properties

    private let loadImageProxy: LoadImageProxy

    // MARK: - Initialization

    init() {
        let imageAPIService = ImageAPIService()
        let cacheImageService = CacheImageService()
        loadImageProxy = LoadImageProxy(service: imageAPIService, cacheImageService: cacheImageService)
    }

    // MARK: - Public Methods

    func getImage(urlPath: String, completion: @escaping (UIImage?) -> ()) {
        loadImageProxy.downloadImage(urlPath: urlPath) { result in
            switch result {
            case let .success(data):
                guard let data = data,
                      let image = UIImage(data: data)
                else {
                    completion(nil)
                    return
                }
                completion(image)
            case .failure:
                completion(nil)
            }
        }
    }
}
