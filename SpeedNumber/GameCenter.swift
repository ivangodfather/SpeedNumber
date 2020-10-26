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

    init(leaderboardIdentifier: String) {
        self.leaderboardIdentifier = leaderboardIdentifier
        super.init()
    }

    func login(success: @escaping (_ isLogged: Bool) -> Void) {
        GKLocalPlayer.local.authenticateHandler = { authVC, error in
            if let vc = authVC {
                self.viewController!.present(vc, animated: true, completion: nil)
            } else if GKLocalPlayer.local.isAuthenticated {
                success(true)
            } else {
                success(false)
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }

    func loadScores(completion: (([GKLeaderboard.Entry]) -> Void)? = nil) {
        GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier]) { (leaderboards, error) in
            if let leaderboard = leaderboards?.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
                leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...100)) { (local, allPlayers, totalPlayers, error) in
                    if let allPlayers = allPlayers {
                        completion?(allPlayers)
                    }
                }
            }
        }
    }

    func reportScore(_ score: Double) {
        GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier]) { leaderboards, error in
            if let leaderboard = leaderboards?.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
                leaderboard.submitScore(Int(score * 100), context: 0, player: GKLocalPlayer(), completionHandler: { error in
                    print(error?.localizedDescription ?? "")
                })
            }
        }
    }

    func showLeaderboard() {
        let gc = GKGameCenterViewController(leaderboardID: leaderboardIdentifier, playerScope: .global, timeScope: .allTime)
        gc.gameCenterDelegate = self
        viewController?.present(gc, animated: true, completion: nil)
    }

    func loadBestResult(completion: @escaping ((Int?) -> Void)) {
        GKLeaderboard.loadLeaderboards(IDs: [leaderboardIdentifier]) { leaderboards, error in
            if let leaderboard = leaderboards?.filter ({ $0.baseLeaderboardID == self.leaderboardIdentifier }).first {
                leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...100)) { entry, _, _, error  in
                    completion(entry?.score)
                }
            }
        }
    }

}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: false, completion: nil)
    }
}
