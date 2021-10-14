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

    private let networkManager = MovieAPIService()

    // MARK: - Public properties

    func fetchMovie() {
        networkManager.fetchData { [weak self] result in
            guard let self = self,
                  let index = self.indexOfMovie,
                  let updateViewData = self.updateViewData
            else { return }

            switch result {
            case let .success(movies):
                guard let movie = movies?.results?[index] else { return }
                updateViewData(.success(movie))
            case let .failure(error):
                updateViewData(.failure(error))
            }
        }
    }
}