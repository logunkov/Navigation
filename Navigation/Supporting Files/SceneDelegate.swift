//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        window.rootViewController = createTabBar()
        window.makeKeyAndVisible()
        self.window = window

    }

    func createFeedViewController() -> UINavigationController {
        let nvc = UINavigationController(rootViewController: FeedViewController())
        nvc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), tag: 0)
        return nvc
    }

    func createProfileViewController() -> UINavigationController {
        let nvc = UINavigationController(rootViewController: LogInViewController())
        nvc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return nvc
    }

    func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createFeedViewController(), createProfileViewController()]
        return tabBar
    }
}
