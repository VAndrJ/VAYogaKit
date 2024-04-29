//
//  SceneDelegate.swift
//  VAYogaKitExample
//
//  Created by VAndrJ on 25.04.2024.
//

import UIKit
import VANavigator

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var navigator = Navigator(window: window, screenFactory: ScreenFactory())

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)
        navigator.navigate(
            destination: .identity(BaseNavigationIdentity(child: MainScreenNavigationIdentity())),
            strategy: .replaceWindowRoot()
        )
        window?.makeKeyAndVisible()
    }
}
