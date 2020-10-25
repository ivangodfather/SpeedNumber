//
//  GameView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct BoardView: View {

    var completion, leaderboard: () -> Void
    @Binding var gameDuration: TimeInterval
    var currentValue: Int
    var gridContent: [Int]
    var didTapCell: (Int) -> Void
    @State private var scale: Bool = false
    @EnvironmentObject var gameCenter: GameCenter
    private let padding: CGFloat = 4
    @Environment(\.gridSize) var gridSize

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            GameStatusView(
                gameDuration: $gameDuration,
                currentValue: currentValue,
                scale: $scale
            )
            createGrid()
            Spacer()
            MenuView(
                newGame: completion,
                leaderboard: leaderboard
            )
        }
        .background(Color(UIColor.systemBackground))
    }

    var columns: [GridItem] {
        var cols: [GridItem] = []
        for _ in 1...gridSize {
            cols.append(GridItem(.flexible()))
        }
        return cols
    }
    
    private func createGrid() -> some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(gridContent.enumerated()), id:\.0) { index, element in
                TileView(index: index, value: element) {
                    self.animate()
                    self.didTapCell(index)
                }.aspectRatio(contentMode: .fill)
            }
        }
    }

    private func animate() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            self.scale.toggle()
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.scale.toggle()
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone SE", "iPhone XS Max", "iPad Pro (12.9-inch) (3rd generation)"], id: \.self) { deviceName in
                BoardView(completion: {},
                         leaderboard: {},
                         gameDuration: .constant(3),
                         currentValue: 2,
                         gridContent: [99, 2, 3, 4, 5,
                                       1, 2, 3, 4, 5,
                                       1, 2, 3, 4, 5,
                                       1, 2, 3, 4, 5,
                                       1, 2, 3, 4, 5],
                         didTapCell: { _ in }
                ).previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }

    }
}
