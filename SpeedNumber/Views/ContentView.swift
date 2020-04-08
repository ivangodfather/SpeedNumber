//
//  ContentView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

enum GameState {
    case idle
    case running
    case finished
}

struct ContentView: View {
    
    @Environment(\.gridSize) var gridSize
    
    @State private var gridContent: [[Int]] = []
    @State private var currentValue = 1
    @State private var gameState = GameState.idle
    @State private var gameDuration: TimeInterval = 0.0
    private var targetValue: Int { gridSize * gridSize * 2 }
    @EnvironmentObject var gameCenter: GameCenter
    @State var isAlertGameCenterPresented = false
    
    private let notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    
    var body: some View {
        Group {
            if gameState == .finished {
                ScoreView(
                    score: gameDuration.score,
                    maxScore: self.gameCenter.loadBestResult()?.score,
                    completion: didTapNewGame
                )
            }
            else if gameState == .running {
                GameView(
                    completion: didTapNewGame,
                    leaderboard: showLeaderboard,
                    gameDuration: $gameDuration,
                    currentValue: currentValue,
                    gridContent: gridContent,
                    didTap: didTap
                )
            } else {
                WelcomeScreenView(
                    versionText: versionText(),
                    newGame: didTapNewGame,
                    leaderboard: showLeaderboard
                ).alert(isPresented: $isAlertGameCenterPresented) {
                    Alert(title: Text(NSLocalizedString(Translation.gameCenterErrorTitle,comment: "")),
                          message: Text(NSLocalizedString(Translation.gameCenterErrorDescription, comment: "")),
                          primaryButton: .default(Text(NSLocalizedString(Translation.goToSettings, comment: "")), action: { UIApplication.shared.openSettings() }),
                        secondaryButton: .destructive(Text(NSLocalizedString(Translation.continueWithoutGameCenter, comment: ""))))
                }
            }
        }.onAppear {
            self.notificationFeedbackGenerator.prepare()
        }
    }
    
    func showLeaderboard() {
        if !gameCenter.showLeaderboard() {
            self.isAlertGameCenterPresented.toggle()
        }
    }
    
    private func versionText() -> String {

        return "SpeedyNumbers v.\(Bundle.main.releaseVersion) build \(Bundle.main.buildVersion)\nCopyright © 2020 Iván Ruiz Monjo"
    }
    
    private func didTapNewGame() {
        switch gameState {
        case .idle:
            resetGame()
            gameState = .running
        case .running:
            gameState = .idle
        case .finished:
            gameState = .idle
        }
    }
    
    private func resetGame() {
        gameDuration = 0
        currentValue = 1
        var content = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
        var contents = Array(1...gridSize * gridSize).shuffled()
        for x in 0...gridSize - 1 {
            for y in 0...gridSize - 1 {
                content[x][y] = contents.popLast() ?? 0
            }
        }
        gridContent = content
    }
    
    private func didTap(_ x: Int, _ y: Int) {
        let isCorrectCell = currentValue == gridContent[x][y]


        let nextSlot = gridSize * gridSize + currentValue
        applyFeedback(isCorrectCell)
        if isCorrectCell {
            currentValue += 1
            gridContent[x][y] = nextSlot <= targetValue ? nextSlot : 0
        }
        checkGameIsEnded()
    }
    
    private func applyFeedback(_ isCorrect: Bool) {

        if !isCorrect {
            notificationFeedbackGenerator.notificationOccurred( .error)
        }
    }
    
    private func checkGameIsEnded() {
        if currentValue > targetValue {
            gameState = currentValue < targetValue ? .idle : .finished
            #if RELEASE
            self.gameCenter.reportScore(gameDuration)
            #endif
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameCenter(leaderboardIdentifier: "random"))
    }
}
