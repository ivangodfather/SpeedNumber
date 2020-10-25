//
//  GameViewModel.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 18/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

enum GameState {
    case idle
    case running
    case finished
}

final class GameViewModel: ObservableObject {

    @Published var gameState = GameState.idle
    @Published var gridContent: [[Int]] = []
    @Published var currentValue = 1
    @Published var gameDuration: TimeInterval = 0.0
    @Environment(\.gridSize) var gridSize

    private var targetValue: Int { gridSize * gridSize * 2 }
    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()

    func didTapNewGame() {
        switch gameState {
        case .idle:
            resetGame()
            gameState = .running
        case .running, .finished:
            gameState = .idle
        }
    }

    func didTapCell(_ x: Int, _ y: Int) {
        let isCorrectCell = currentValue == gridContent[x][y]

        let nextSlot = gridSize * gridSize + currentValue
        applyFeedback(isCorrectCell)
        if isCorrectCell {
            currentValue += 1
            gridContent[x][y] = nextSlot <= targetValue ? nextSlot : 0
        }
        checkGameIsEnded()
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

    private func checkGameIsEnded() {
        if currentValue > targetValue {
            gameState = currentValue < targetValue ? .idle : .finished
            #if RELEASE
            self.gameCenter.reportScore(gameDuration)
            #endif
        }
    }

    private func applyFeedback(_ isCorrect: Bool) {
        if !isCorrect {
            notificationFeedbackGenerator.notificationOccurred( .error)
        }
    }

    var versionText: String {
        """
        SpeedyNumbers v.\(Bundle.main.releaseVersion) build \(Bundle.main.buildVersion)
        Copyright © 2020 Iván Ruiz Monjo
        """
    }
}
