// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// FetchDataResult
enum FetchDataResult {
    case success(movies: Movies?)
    case failure(error: Error)
}

/// NetworkManager
final class NetworkManager {
    // MARK: - Private properties

    private let mainUrlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=8e0fd47116b402cc2a7d63678e0b939e"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    // MARK: - Public methods

    func fetchData(completion: @escaping (FetchDataResult) -> Void) {
        guard let url = URL(string: mainUrlString) else { return }

        session.dataTask(with: url) { [weak self] data, _, error in
            var result: FetchDataResult

            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if let error = error {
                result = .failure(error: error)
                return
            }

            guard let data = data, let movies = try? self?.decoder.decode(Movies.self, from: data) else {
                result = .success(movies: nil)
                return
            }

            result = .success(movies: movies)
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
