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
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        Group {
            switch viewModel.gameState {
            case .finished:
                ScoreView(
                    score: viewModel.gameDuration.score,
                    maxScoreHandler: self.gameCenter.loadBestResult,
                    completion: viewModel.didTapNewGame
                )
            case .running:
                BoardView(
                    completion: viewModel.didTapNewGame,
                    leaderboard: self.gameCenter.showLeaderboard,
                    gameDuration: $viewModel.gameDuration,
                    currentValue: viewModel.currentValue,
                    gridContent: viewModel.gridContent,
                    didTapCell: viewModel.didTapCell
                )
            case .idle:
                WelcomeScreenView(
                    versionText: viewModel.versionText,
                    newGame: viewModel.didTapNewGame,
                    leaderboard: self.gameCenter.showLeaderboard
                )
            }
        }.onAppear {
            self.viewModel.notificationFeedbackGenerator.prepare()
            self.viewModel.gameCenter = gameCenter
        }
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameCenter(leaderboardIdentifier: "random"))
    }
}
