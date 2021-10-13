// MovieAPIService.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

final class MovieAPIService {
    // MARK: - Private properties

    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    // MARK: - Public methods

    func fetchData(completion: @escaping (Result<Movies?, Error>) -> Void) {
        guard let url = URL(string: Constants.mainUrlString) else { return }

        session.dataTask(with: url) { [weak self] data, _, error in
            var result: Result<Movies?, Error>

            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                result = .failure(error)
                return
            }

            guard let data = data,
                  let movies = try? self?.decoder.decode(Movies.self, from: data)
            else {
                result = .success(nil)
                return
            }

            result = .success(movies)
        }.resume()
    }

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
