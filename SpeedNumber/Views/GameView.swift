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
                    leaderboard: showLeaderboard,
                    gameDuration: $viewModel.gameDuration,
                    currentValue: viewModel.currentValue,
                    gridContent: viewModel.gridContent,
                    didTapCell: viewModel.didTapCell
                )
            case .idle:
                WelcomeScreenView(
                    versionText: viewModel.versionText,
                    newGame: viewModel.didTapNewGame,
                    leaderboard: showLeaderboard
                ).alert(isPresented: $isAlertGameCenterPresented) {
                    gameCenterAlert()
                }
            }
        }.onAppear {
            self.viewModel.notificationFeedbackGenerator.prepare()
        }
    }

    private func showLeaderboard() {
        gameCenter.showLeaderboard { _ in
            self.isAlertGameCenterPresented.toggle()
        }
    }

    private func gameCenterAlert() -> Alert {
        Alert(title: Text(Translation.gameCenterErrorTitle),
              message: Text(Translation.gameCenterErrorDescription),
              primaryButton: .default(Text(Translation.goToSettings), action: { UIApplication.shared.openSettings() }),
              secondaryButton: .destructive(Text(Translation.continueWithoutGameCenter)))
    }

}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameCenter(leaderboardIdentifier: "random"))
    }
}
