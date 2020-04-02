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
    private var gridSize = 2
    
    @State private var gridContent: [[Int]] = []
    @State private var currentValue = 1
    @State private var gameState = GameState.idle
    @State private var gameDuration: TimeInterval = 0.0
    private var targetValue: Int { gridSize * gridSize }

    
    var body: some View {
        Group {
            if gameState == .finished {
                ScoreView(
                    score: gameDuration.value,
                    completion: updateState
                )
            }
            else if gameState == .running {
                GameView(
                    completion: updateState,
                    gameDuration: $gameDuration,
                    currentValue: currentValue,
                    gridContent: gridContent,
                    didTap: didTap
                )
            } else {
                WelcomeScreenView(
                    newGame: updateState,
                    leaderboard: GameCenter.shared.showLeaderBoard
                )
            }
        }
    }
    
    private func updateState() {
        switch gameState {
        case .idle:
            resetGame()
            gameState = .running
        case .running:
            gameState = currentValue < targetValue ? .idle : .finished
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
        let nextSlot = gridSize * gridSize + currentValue
        if currentValue == gridContent[x][y] {
            withAnimation {
                currentValue += 1
            }
            gridContent[x][y] = nextSlot <= gridSize * 2 ? nextSlot : 0
            if currentValue > gridSize * 2 {
                self.gameState = .finished
                print("win! with time \(gameDuration)")
                GameCenter.shared.reportScore(gameDuration)
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
