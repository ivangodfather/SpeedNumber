//
//  GameView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameView: View {
    
    var completion: () -> ()
    let leaderBoard: () -> Bool
    @Binding var gameDuration: TimeInterval
    var currentValue: Int
    var gridContent: [[Int]]
    var didTap: (_ x: Int, _ y: Int) -> ()
    @State private var scale: Bool = false
    @EnvironmentObject var gameCenter: GameCenter
    private let padding: CGFloat = 4
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: UIScreen.main.bounds.size.height / 25)

            GameStatusView(
                gameDuration: $gameDuration,
                currentValue: currentValue,
                scale: $scale
            )
            createGrid()
            MenuView(
                newGame: completion,
                leaderboard: self.gameCenter.showLeaderBoard
            )
        }
        .background(Color(UIColor.systemBackground))
    }
    
    private func createGrid() -> some View {
        
        GeometryReader { proxy in
            VStack(spacing: self.padding) {
                ForEach(0...self.gridContent.count - 1, id: \.self) { y in
                    HStack(spacing: self.padding) {
                        ForEach(0...self.gridContent.first!.count - 1, id: \.self) { x in
                            TileView(x: x, y: y, value: self.gridContent[x][y]) {
                                self.animate()
                                self.didTap(x, y)
                            }
                        }
                    }
                }
            }
            .padding(self.padding)
            .frame(width: min(proxy.size.width, proxy.size.height),
                   height: min(proxy.size.width, proxy.size.height))
            Spacer()
        }

    }
    
    private func animate() {
        withAnimation(Animation.easeInOut(duration: 0.3))  {
            self.scale.toggle()
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                withAnimation(Animation.easeInOut(duration: 0.5))  {
                    self.scale.toggle()
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(completion: {},
                 leaderBoard: { true },
                 gameDuration: .constant(3),
                 currentValue: 2,
                 gridContent: [[99, 2, 3, 4, 5],
                               [1, 2, 3, 4, 5],
                               [1, 2, 3, 4, 5],
                               [1, 2, 3, 4, 5],
                               [1, 2, 3, 4, 5]],
                 didTap: { _, _ in }
        )
            .environmentObject(GameCenter(leaderboardIdentifier: "x"))
            .colorScheme(.dark)
    }
}
