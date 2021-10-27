// ImageAPIService.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation

final class ImageAPIService: LoadImageProtocol {
    private let session = URLSession.shared

    func downloadImage(urlPath: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        let urlString = Constants.getPosterURLString(path: urlPath)
        guard let url = URL(string: urlString)
        else {
            completion(.failure(CustomError.urlIsNil))
            return
        }

        session.dataTask(with: url) { data, _, error in
            var result: Result<Data?, Error>

            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                result = .failure(error)
                return
            }
            guard let data = data else {
                result = .success(nil)
                return
            }

            result = .success(data)
        }.resume()
    }
}
