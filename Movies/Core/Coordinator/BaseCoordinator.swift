// BaseCoordinator.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

/// Base coordinator
class BaseCoordinator {
    // MARK: - Public Properties

    var childCoordinators: [BaseCoordinator] = []

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator
        else { return }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
