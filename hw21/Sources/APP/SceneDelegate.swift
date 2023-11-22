//
//  SceneDelegate.swift
//  hw21
//
//  Created by Нурдаулет on 17.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = ViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

    }

}

