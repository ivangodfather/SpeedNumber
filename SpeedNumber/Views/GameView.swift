//
//  ContentView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    @EnvironmentObject var gameCenter: GameCenter
    @State var isAlertGameCenterPresented = false
    @ObservedObject private var viewModel = GameViewModel()
    
    var body: some View {
        Group {
            if viewModel.gameState == .finished {
                ScoreView(
                    score: viewModel.gameDuration.score,
                    maxScore: self.gameCenter.loadBestResult()?.score,
                    completion: viewModel.didTapNewGame
                )
            }
            else if viewModel.gameState == .running {
                BoardView(
                    completion: viewModel.didTapNewGame,
                    leaderboard: showLeaderboard,
                    gameDuration: $viewModel.gameDuration,
                    currentValue: viewModel.currentValue,
                    gridContent: viewModel.gridContent,
                    didTapCell: viewModel.didTapCell
                )
            } else {
                WelcomeScreenView(
                    versionText: versionText(),
                    newGame: viewModel.didTapNewGame,
                    leaderboard: showLeaderboard
                ).alert(isPresented: $isAlertGameCenterPresented) {
                    Alert(title: Text(NSLocalizedString(Translation.gameCenterErrorTitle,comment: "")),
                          message: Text(NSLocalizedString(Translation.gameCenterErrorDescription, comment: "")),
                          primaryButton: .default(Text(NSLocalizedString(Translation.goToSettings, comment: "")), action: { UIApplication.shared.openSettings() }),
                        secondaryButton: .destructive(Text(NSLocalizedString(Translation.continueWithoutGameCenter, comment: ""))))
                }
            }
        }.onAppear {
            self.viewModel.notificationFeedbackGenerator.prepare()
        }
    }
    
    func showLeaderboard() {
        gameCenter.showLeaderboard { hasShown in
            self.isAlertGameCenterPresented.toggle()
        }
    }
    
    private func versionText() -> String {
        return "SpeedyNumbers v.\(Bundle.main.releaseVersion) build \(Bundle.main.buildVersion)\nCopyright © 2020 Iván Ruiz Monjo"
    }
    

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameCenter(leaderboardIdentifier: "random"))
    }
}
