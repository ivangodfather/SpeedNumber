//
//  SceneDelegate.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit
import SwiftUI

@main struct SpeedNumberApp: App {
    private let gameCenter = GameCenter(leaderboardIdentifier: "speedynumbers")

    var body: some Scene {
        WindowGroup {
            GameView().environmentObject(gameCenter).onAppear {
                gameCenter.viewController = UIApplication.shared.windows.first?.rootViewController
                gameCenter.login { _ in
                }
            }
        }
    }
}
