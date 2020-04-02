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
    let leaderboard: () -> ()
    
    var body: some View {
        VStack {
            Text("SpeedyNumbers v0.1 by Iván Ruiz")
            .font(Font.system(.footnote, design: .monospaced))
            Spacer()
            Text("Tap to start")
                .font(Font.system(.largeTitle, design: .monospaced))
                .padding(32)
            Text("Try to follow de sequence as fast as you can!")
                .padding(32)
                .font(Font.system(.headline, design: .monospaced))
            Spacer()
            MenuView(newGame: newGame, leaderboard: leaderboard)

        }
        .onTapGesture {
            self.newGame()
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView(newGame: {}, leaderboard: {})
    }
}
