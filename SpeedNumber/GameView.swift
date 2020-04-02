//
//  GameView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    var newGame: () -> ()
    @Binding var gameDuration: TimeInterval
    var currentValue: Int
    var gridContent: [[Int]]
    var didTap: (_ x: Int, _ y: Int) -> ()
    
    var body: some View {
        VStack {
            GameStatusView(
                gameDuration: $gameDuration,
                currentValue: currentValue
            )
            createGrid()
                .padding([Edge.Set.leading, .trailing], 15)
            Spacer()
            
            MenuView(
                newGame: self.newGame,
                leaderboard:GameCenter.shared.showLeaderBoard
            )
        }
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
                            .frame(width: proxy.size.width / CGFloat(self.gridContent.count),
                                   height: proxy.size.width / CGFloat(self.gridContent.count))
                        }
                    }
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(newGame: { }, gameDuration: .constant(3), currentValue: 1, gridContent: [[]], didTap: { _, _ in })
    }
}
