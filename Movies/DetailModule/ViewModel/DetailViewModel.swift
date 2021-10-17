// DetailViewModel.swift
// Copyright © Roadmap. All rights reserved.

import Foundation

protocol MovieDetailViewModelProtocol {
    var updateViewData: ((ViewData<Movie>) -> ())? { get set }
    var indexOfMovie: Int? { get set }
    func fetchMovie()
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public properties

    var updateViewData: ((ViewData<Movie>) -> ())?
    var indexOfMovie: Int?

    // MARK: - Private properties

    private let movieAPIService: MovieAPIServiceProtocol
    private let databaseRepository: DatabaseRepository<Movie>

    // MARK: - Initialisation

    init(
        movieAPIService: MovieAPIServiceProtocol,
        databaseRepository: DatabaseRepository<Movie>,
        indexOfMovie: Int?
    ) {
        self.movieAPIService = movieAPIService
        self.databaseRepository = databaseRepository
        self.indexOfMovie = indexOfMovie
    }

    // MARK: - Public properties

    func fetchMovie() {
        guard let moviesFromRealm = databaseRepository.get(),
              let index = indexOfMovie
        else { return }

        if moviesFromRealm.isEmpty {
            getMoviesFromNetworkAndSaveToDatabase(index: index)
        } else {
            updateViewData?(.success(moviesFromRealm[index]))
        }
    }

    // MARK: - Private methods

    private func getMoviesFromNetworkAndSaveToDatabase(index: Int) {
        movieAPIService.fetchData { [weak self] result in
            guard let self = self,
                  let updateViewData = self.updateViewData
            else { return }

            switch result {
            case let .success(movies):
                guard let moviesResult = movies?.results else { return }
                DispatchQueue.main.async {
                    self.databaseRepository.save(moviesResult)
                    guard let movies = self.databaseRepository.get() else { return }
                    self.updateViewData?(.success(movies[index]))
                }
            case let .failure(error):
                updateViewData(.failure(error))
            }
        }
    }
}
