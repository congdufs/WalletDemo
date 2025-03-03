//
//  SceneDelegate.swift
//  WalletDemo
//
//  Created by congdufs on 2025/3/2.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var tabBarController: UITabBarController?
    private var homeNav: UINavigationController?
    private var transactionNav: UINavigationController?
    private var assetNav: UINavigationController?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        setupTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    // MARK: - private
    private func setupTabBarController() {
        tabBarController = UITabBarController()
        homeNav = UINavigationController(rootViewController: HomeViewController())
        transactionNav = UINavigationController(rootViewController: UIViewController()) // 空页面
        assetNav = UINavigationController(rootViewController: AssetViewController())
        guard let tabBarController = tabBarController, let homeNav = homeNav, let transactionNav = transactionNav, let assetNav = assetNav else { return }
        // 配置Tab Bar
        homeNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "home_normal"),
            selectedImage: UIImage(named: "home_selected")
        )
        let transactionImage = UIImage(named: "transaction")?.withRenderingMode(.alwaysOriginal)
        transactionNav.tabBarItem = UITabBarItem(
            title: nil,
            image: transactionImage,
            selectedImage: transactionImage
        )
        assetNav.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "asset_normal"),
            selectedImage: UIImage(named: "asset_selected")
        )
        
        tabBarController.delegate = self
        tabBarController.viewControllers = [homeNav, transactionNav, assetNav]
        tabBarController.selectedIndex = 2// todoo
        tabBarController.tabBar.tintColor = .gray
    }
}

// MARK: - TabBar delegate
extension SceneDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == transactionNav { // 拦截页面，弹出actionsheet
            showTransactionActionSheet(currentVC: tabBarController.selectedViewController)
            return false
        }
        return true
    }
    
    private func showTransactionActionSheet(currentVC: UIViewController?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Send", style: .default))
        alert.addAction(UIAlertAction(title: "Receive", style: .default))
        alert.addAction(UIAlertAction(title: "Buy", style: .default))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        currentVC?.present(alert, animated: true)
    }
}
