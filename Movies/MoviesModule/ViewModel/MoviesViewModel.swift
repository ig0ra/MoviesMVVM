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

    private let movieAPIService: MovieAPIServiceProtocol

    // MARK: - Initialization

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    // MARK: - Public methods

    func fetchMovies() {
        movieAPIService.fetchData { [weak self] result in
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
