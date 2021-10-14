// MoviesViewModel.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

protocol MoviesViewModelProtocol {
    var updateViewData: ((ViewData<Movies>) -> ())? { get set }
    func fetchMovies()
}

final class MoviesViewModel: MoviesViewModelProtocol {
    // MARK: - Public properties

    var updateViewData: ((ViewData<Movies>) -> ())?

    // MARK: - Private properties

    private let networkManager = MovieAPIService()

    // MARK: - Public methods

    func fetchMovies() {
        networkManager.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let movies = movies else { return }
                self.updateViewData?(.success(movies))
            case let .failure(error):
                print(error)
            }
        }
    }
}
