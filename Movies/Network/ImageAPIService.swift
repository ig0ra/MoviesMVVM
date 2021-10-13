// ImageAPIService.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

final class ImageAPIService {
    private let session = URLSession.shared

    func fetchImage(with urlString: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        guard let url = URL(string: urlString) else {
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
