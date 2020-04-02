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

final class GameCenter: NSObject, GKLocalPlayerListener {
    
    static let shared = GameCenter()
    
    static var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
    
    var viewController: UIViewController?
    
    override init() {
        super.init()
        
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.register(self)
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true, completion: nil)
            }
            else {
                print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    func reportScore(_ score: Double) {
        let gkScore = GKScore(leaderboardIdentifier: "speedynumbers")
        gkScore.value = Int64(score * 100)
        gkScore.context = 0
        GKScore.report([gkScore]) { error in
            print("")
        }
    }
    
    func showLeaderBoard() {
        let gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        viewController?.present(gc, animated: true, completion: {
            
        })
    }
        
}

extension GameCenter: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
}

