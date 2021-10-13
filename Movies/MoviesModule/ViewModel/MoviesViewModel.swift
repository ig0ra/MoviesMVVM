// MoviesViewModel.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

protocol MoviesViewModelProtocol {
    var updateViewMovies: ((MoviesViewData) -> ())? { get set }
    func fetchMovies()
}

final class MoviesViewModel: MoviesViewModelProtocol {
    // MARK: - Public properties

    var updateViewMovies: ((MoviesViewData) -> ())?

    // MARK: - Private properties

    private let networkManager = NetworkManager()

    // MARK: - Public methods

    func fetchMovies() {
        networkManager.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else { return }
                self.updateViewMovies?(.success(movies))
            case let .failure(error):
                print(error)
            }
        }
    }
}
