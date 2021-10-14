// MoviesCoordinator.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesCoordinator: BaseCoordinator {
    // MARK: - Public properties

    var onFinishFlow: (() -> ())?

    // MARK: - Private properties

    private var assemblyModule: AssemblyProtocol?
    private var navigationController: UINavigationController?

    // MARK: - Initialization

    required init(assemblyModule: AssemblyProtocol, navigationController: UINavigationController?) {
        self.assemblyModule = assemblyModule
        self.navigationController = navigationController
    }

    // MARK: - BaseCoordinator

    override func start() {
        showMoviesModule()
    }

    private func showMoviesModule() {
        guard let viewController = assemblyModule?.createMoviesModule() as? MoviesViewController
        else { return }

        viewController.tapCell = { [weak self] index in
            guard let self = self else { return }
            self.pushMoviesDetailModule(indexOfMovie: index)
        }

        navigationController = UINavigationController(rootViewController: viewController)
        guard let navigationController = navigationController else { return }
        setAsRoot(navigationController)
    }

    private func pushMoviesDetailModule(indexOfMovie: Int?) {
        guard let viewController = assemblyModule?.createDetailModule(indexOfMovie: indexOfMovie)
            as? MovieDetailViewController
        else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
