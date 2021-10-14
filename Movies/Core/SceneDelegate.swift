// SceneDelegate.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        let assembyModule = AssemblyModule()
        let moviesVC = assembyModule.createMoviesModule()
        let navController = UINavigationController(rootViewController: moviesVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
    }
}
