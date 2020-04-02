//
//  WelcomeScreenView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

struct WelcomeScreenView: View {
    
    let newGame: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Tap to start")
            .font(Font.system(.largeTitle, design: .monospaced))
                .padding(.bottom, 32)
            Text("Try to follow de sequence as fast as you can!")
            .font(Font.system(.headline, design: .monospaced))
            Spacer()
            Button(action: { GameCenter.shared.showLeaderBoard() }) {
                HStack {
                    Image(systemName: "gamecontroller")
                    Text("Leaderboard")
                }
            }.foregroundColor(.primary)
        }
        .padding(32)
        .onTapGesture {
            self.newGame()
        }
    }
}
