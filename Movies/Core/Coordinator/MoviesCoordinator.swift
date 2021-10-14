// MoviesCoordinator.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class MoviesCoordinator: BaseCoordinator {
    // MARK: - Public properties

    var onFinishFlow: (() -> ())?

    // MARK: - Private properties

    private var rootViewController: UINavigationController?
    private var assemblyModule: AssemblyProtocol?

    // MARK: - Initialization

    init(assemblyModule: AssemblyProtocol) {
        self.assemblyModule = assemblyModule
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

        rootViewController = UINavigationController(rootViewController: viewController)
        guard let rootViewController = rootViewController else { return }
        setAsRoot(rootViewController)
    }

    private func pushMoviesDetailModule(indexOfMovie: Int?) {
        guard let viewController = assemblyModule?.createDetailModule(indexOfMovie: indexOfMovie)
            as? MovieDetailViewController
        else { return }
        rootViewController?.pushViewController(viewController, animated: true)
    }
}
