//
//  SceneDelegate.swift
//  TestTaskMacPaw
//
//  Created by Admin on 16.04.2020.
//  Copyright © 2020 Mykola Korotun. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window?.makeKeyAndVisible()
        
        let tabbarController = TabBarController()
        let navController = UINavigationController(rootViewController: tabbarController)
        navController.modalPresentationStyle = .fullScreen
        window?.rootViewController = navController
    }
    
}

