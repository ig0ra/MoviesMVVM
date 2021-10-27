// ApplicationCoordinator.swift
// Copyright © Igor Obrizko. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Private properties

    private var assemblyModule: AssemblyProtocol
    private var navigationController: UINavigationController?

    // MARK: - BaseCoordinator

    required init(assemblyModule: AssemblyProtocol, navigationController: UINavigationController? = nil) {
        self.assemblyModule = assemblyModule
        self.navigationController = navigationController
    }

    override func start() {
        toMoviesView()
    }

    // MARK: - Private Methods

    private func toMoviesView() {
        let coordinator = MoviesCoordinator(
            assemblyModule: assemblyModule,
            navigationController: navigationController
        )
        coordinator.onFinishFlow = { [weak coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
