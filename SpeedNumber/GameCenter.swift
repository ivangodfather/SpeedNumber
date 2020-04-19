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

    func login(success: @escaping (_ isLogged: Bool) -> Void) {
        GKLocalPlayer.local.authenticateHandler = { authVC, error in
            if let vc = authVC {
                self.viewController?.present(vc, animated: true, completion: nil)
            } else if GKLocalPlayer.local.isAuthenticated {
                success(true)
            } else {
                success(false)
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }

    func loadScores(completion: (([GKScore]) -> Void)? = nil) {
        leaderboard.playerScope = .global
        leaderboard.timeScope = .allTime
        leaderboard.loadScores { scores, _ in
            if let scores = scores {
                completion?(scores)
            }
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

    func showLeaderboard(hasShown: @escaping (Bool) -> Void) {
        var hasPresented = false

        guard GKLocalPlayer.local.isAuthenticated else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                if hasPresented == false {
                    hasShown(false)
                    return
                }
            }
            login { success in
                hasPresented = true
                if success {
                    self.presentLeaderBoard()
                }
            }
            return
        }
        hasShown(true)
        presentLeaderBoard()
    }

    private func presentLeaderBoard() {
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
        gameCenterViewController.dismiss(animated: false, completion: nil)
    }
}
