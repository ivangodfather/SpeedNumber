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
    private let maxNumber = 6
    @State private var gridSize = 2
    @State private var gridContent: [[Int]] = []
    @State private var currentValue = 1
    var timerView = TimerView()
    
    @State private var gameState = GameState.idle
    
    var body: some View {
        VStack {
            HStack {
                if gameState == .running {
                    TimerView()
                }
                Spacer()
                Button(action: { self.newGame() }) {
                    Text("New game")
                }
            }
            CurrentValueView(currentValue: currentValue)
            Group {
                if gridContent.isEmpty {
                    Text("Loading")
                } else {
                    createGrid()
                }
                
            }
            Spacer()
        }
        .font(Font.system(.body, design: .monospaced))
    }
    
    private func newGame() {
        if gameState == .idle {
            gameState = .running
        } else {
            gameState = .idle
        }
        self.currentValue = 1
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
            VStack(spacing: 0) {
                ForEach(0...self.gridContent.count - 1, id: \.self) { y in
                    HStack(spacing: 0) {
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
        print(nextSlot)
        if currentValue == gridContent[x][y] {
            currentValue += 1
            gridContent[x][y] = nextSlot <= maxNumber ? nextSlot : 0
            if currentValue > maxNumber {
                print("win!")
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
