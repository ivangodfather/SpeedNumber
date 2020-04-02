//
//  MenuView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuView: View {
    
    let newGame, leaderboard: () -> ()
    @EnvironmentObject var gameCenter: GameCenter
    
    var body: some View {
        HStack {
            Button(action: { self.newGame() }) {
                HStack {
                    Image(systemName: "play")
                    Text("Play")
                }
            }
            Spacer()
            Button(action: { self.gameCenter.showLeaderBoard() }) {
                HStack {
                    Image(systemName: "gamecontroller")
                    Text("Leaderboard")
                }
            }
            
        }
        .padding([.bottom, .leading, .trailing], 32)
        .foregroundColor(.primary)
    }
}
