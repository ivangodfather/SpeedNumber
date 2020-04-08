//
//  GameCenter.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import UIKit

import GameKit

final class GameCenter: NSObject, ObservableObject {
    
    var viewController: UIViewController?
    
    
    private let leaderboardIdentifier: String
    private static var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
    private let leaderboard = GKLeaderboard()
    
    
    init(leaderboardIdentifier: String) {
        self.leaderboardIdentifier = leaderboardIdentifier
        super.init()
        leaderboard.identifier = leaderboardIdentifier
    }
    
    func login(succeeded: @escaping (_ isLogged : Bool) -> ()) {
        guard !GKLocalPlayer.local.isAuthenticated else {
            return
        }
        GKLocalPlayer.local.authenticateHandler = { authVC, error in
            if let vc = authVC  {
                self.viewController?.present(vc, animated: true, completion: nil)
            } else if GKLocalPlayer.local.isAuthenticated  {
                succeeded(true)
            }
            else {
                succeeded(false)
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    func loadScores() {
        leaderboard.loadScores { _, _ in
        }
    }
    
    func reportScore(_ score: Double) {
        let gkScore = GKScore(leaderboardIdentifier: leaderboardIdentifier)
        gkScore.value = Int64(score * 100)
        gkScore.context = 0
        GKScore.report([gkScore]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func showLeaderboard() -> Bool {
        guard GKLocalPlayer.local.isAuthenticated else {
            return false
        }
        let gc = GKGameCenterViewController()
        gc.leaderboardIdentifier = leaderboardIdentifier
        gc.gameCenterDelegate = self
        viewController?.present(gc, animated: true, completion: nil)
        return true
    }
    
    func loadBestResult() -> Int64? {
        leaderboard.localPlayerScore?.value
    }
    
}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: false, completion: nil)
    }
}
