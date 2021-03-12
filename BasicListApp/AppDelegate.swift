//
//  AppDelegate.swift
//  BasicListApp
//
//  Created by Luis Belo on 08/03/21.
//
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let startVC = CategoryListViewController()
        let navigationVC = UINavigationController(rootViewController: startVC)
        navigationVC.setupDefaultsConfiguration()
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        return true
    }
}

