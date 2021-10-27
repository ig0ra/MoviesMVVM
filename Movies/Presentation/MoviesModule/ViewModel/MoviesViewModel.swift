// MoviesViewModel.swift
// Copyright © Igor Obrizko. All rights reserved.

import Foundation

protocol MoviesViewModelProtocol {
    var updateViewData: ((ViewData<[Movie]>) -> ())? { get set }
    func fetchMovies()
}

final class MoviesViewModel: MoviesViewModelProtocol {
    // MARK: - Public properties

    var updateViewData: ((ViewData<[Movie]>) -> ())?

    // MARK: - Private properties

    private let movieAPIService: MovieAPIServiceProtocol
    private var databaseRepository: DatabaseRepository<Movie>

    // MARK: - Initialization

    init(
        movieAPIService: MovieAPIServiceProtocol,
        databaseRepository: DatabaseRepository<Movie>
    ) {
        self.movieAPIService = movieAPIService
        self.databaseRepository = databaseRepository
    }

    // MARK: - Public methods

    func fetchMovies() {
        guard let moviesFromRealm = databaseRepository.get() else { return }

        if moviesFromRealm.isEmpty {
            getMoviesFromNetworkAndSaveToDatabase()
        } else {
            updateViewData?(.success(moviesFromRealm))
        }
    }

    // MARK: - Private methods

    private func getMoviesFromNetworkAndSaveToDatabase() {
        movieAPIService.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                guard let moviesResult = movies?.results else { return }
                DispatchQueue.main.async {
                    self.databaseRepository.save(moviesResult)
                    guard let movies = self.databaseRepository.get() else { return }
                    self.updateViewData?(.success(movies))
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
