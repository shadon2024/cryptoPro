//
//  SceneDelegate.swift
//  cryptoPro
//
//  Created by Admin on 01/05/24.
//

import UIKit
import SDWebImage

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        //let first = HomeController()
        window.rootViewController = UINavigationController(rootViewController: HomeController())
        self.window = window
        self.window?.makeKeyAndVisible()
        
        print("DEBAG PRINT", SDImageCache.shared.diskCache.totalSize())
        
        SDImageCache.shared.config.maxDiskSize = 1000000 * 20
        
        
    }


}

