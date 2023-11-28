//
//  SceneDelegate.swift
//  Travio
//
//  Created by Oğuz on 14.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let rootViewController: UIViewController

        if isUserAlreadyLoggedIn() {
            let vc = MainTabbarVC()
            rootViewController = UINavigationController(rootViewController: vc)
        } else {
            let loginVC = LoginVC()
            rootViewController = UINavigationController(rootViewController: loginVC)
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
   
    }

    private func showLoginScreen() {
        let loginVC = LoginVC()
        let rootViewController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = rootViewController
    }

    func isUserAlreadyLoggedIn() -> Bool {
        let accessManager = AccessManager.shared
        
        if let token = accessManager.getToken(accountIdentifier: "access-token") {
            return token.count != 10
        }
        
        return true
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

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
