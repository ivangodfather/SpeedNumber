//
//  SceneDelegate.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let gameCenter = GameCenter(leaderboardIdentifier: "speedynumbers")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()
            .environmentObject(gameCenter)
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            gameCenter.viewController = window.rootViewController
            gameCenter.login { [weak self] isLogged in
                if isLogged {
                    self?.gameCenter.loadScores()
                } else {
                    self?.tryToEnableGameCenter()
                }
            }
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
    private func tryToEnableGameCenter() {
        let alert = UIAlertController(title: NSLocalizedString(Translation.gameCenterErrorTitle,comment: ""),
                                      message: NSLocalizedString(Translation.gameCenterErrorDescription, comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString(Translation.goToSettings, comment: ""), style: .default, handler: { alert in
            UIApplication.shared.openSettings()
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString(Translation.continueWithoutGameCenter, comment: ""),
                                      style: .destructive, handler: nil))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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


}
