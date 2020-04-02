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
    @State private var gridSize = 5
    @State private var gridContent: [[Int]] = []
    @State private var currentValue = 1
    
    @State private var gameState = GameState.idle
    @State private var gameDuration: TimeInterval = 0.0
    @State private var isActive = true
    

    
    var body: some View {
        Group {
            if gameState == .finished {
                ScoreView(score: gameDuration.value) {
                    self.newGame()
                }
            }
            else if gameState == .running {
                GameView(
                    newGame: newGame,
                    gameDuration: $gameDuration,
                    currentValue: currentValue,
                    gridContent: gridContent,
                    didTap: didTap
                )
            } else {
                WelcomeScreenView(newGame: self.newGame)
            }
        }
    }
    
    private func newGame() {
        if gameState == .finished {
            gameState = .idle
            return
        }
        gameDuration = 0
        currentValue = 1
        gameState = .running
        var content = Array(repeating: Array(repeating: 0, count: gridSize), count: gridSize)
        var contents = Array(1...gridSize * gridSize).shuffled()
        for x in 0...gridSize - 1 {
            for y in 0...gridSize - 1 {
                content[x][y] = contents.popLast() ?? 0
            }
        }
        gridContent = content
    }
    
    private func createGrid() -> some View {
        GeometryReader { proxy in
            VStack(spacing: 5) {
                ForEach(0...self.gridContent.count - 1, id: \.self) { y in
                    HStack(spacing: 5) {
                        ForEach(0...self.gridContent.first!.count - 1, id: \.self) { x in
                            TileView(x: x, y: y, value: self.gridContent[x][y]) {
                                self.didTap(x, y)
                            }
                            .frame(width: proxy.size.width / CGFloat(self.gridSize),
                                   height: proxy.size.width / CGFloat(self.gridSize))
                        }
                    }
                }
            }
        }
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
