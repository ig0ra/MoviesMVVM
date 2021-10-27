// SceneDelegate.swift
// Copyright © Igor Obrizko. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark

        let assembyModule = AssemblyModule()
        coordinator = ApplicationCoordinator(assemblyModule: assembyModule)
        coordinator?.start()
    }
}
