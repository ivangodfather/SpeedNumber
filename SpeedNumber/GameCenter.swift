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
        
        //        showLogin()
        leaderboard.identifier = leaderboardIdentifier
        loadScores()
    }
    
    private func showLogin(completion: (() -> ())? = nil) {
        guard !GKLocalPlayer.local.isAuthenticated else {
            return
        }
        GKLocalPlayer.local.authenticateHandler = { authVC, error in
            if let vc = authVC  {
                self.viewController?.present(vc, animated: true, completion: completion)
            } else if GKLocalPlayer.local.isAuthenticated  {
                print("woho")
            }
            else {
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    private func loadScores() {
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
    
    func showLeaderBoard() {
        guard GKLocalPlayer.local.isAuthenticated else {
            showLogin(completion: nil)
            return
        }
        let gc = GKGameCenterViewController()
        gc.leaderboardIdentifier = leaderboardIdentifier
        gc.gameCenterDelegate = self
        viewController?.present(gc, animated: true, completion: nil)
    }
    
    func loadBestResult() -> Int64? {
        leaderboard.localPlayerScore?.value
    }
    
}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
