// ApplicationCoordinator.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    private var assemblyModule: AssemblyProtocol
    private var navigationController: UINavigationController?

    // MARK: - BaseCoordinator

    init(assemblyModule: AssemblyProtocol) {
        self.assemblyModule = assemblyModule
    }

    override func start() {
        toMoviesView()
    }

    // MARK: - Private Methods

    private func toMoviesView() {
        let coordinator = MoviesCoordinator(assemblyModule: assemblyModule)
        coordinator.onFinishFlow = { [weak coordinator] in
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
