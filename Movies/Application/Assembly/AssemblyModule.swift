// AssemblyModule.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

protocol AssemblyProtocol {
    func createMoviesModule() -> UIViewController
    func createDetailModule(indexOfMovie: Int?) -> UIViewController
}

final class AssemblyModule: AssemblyProtocol {
    func createMoviesModule() -> UIViewController {
        let movieAPIService = MovieAPIService()
        let realmRepository = RealmRepository<Movie>()
        let viewModel = MoviesViewModel(
            movieAPIService: movieAPIService,
            databaseRepository: realmRepository
        )
        let viewControler = MoviesViewController(viewModel: viewModel)
        return viewControler
    }

    func createDetailModule(indexOfMovie: Int?) -> UIViewController {
        let movieAPIService = MovieAPIService()
        let realmRepository = RealmRepository<Movie>()
        let viewModel = MovieDetailViewModel(
            movieAPIService: movieAPIService,
            databaseRepository: realmRepository,
            indexOfMovie: indexOfMovie
        )
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
