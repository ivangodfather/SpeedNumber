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
    
    var body: some View {
        HStack {
            Button(action: { self.newGame() }) {
                HStack {
                    Image(systemName: "play")
                    Text("PLAY")
                }
            }
            Spacer()
            Button(action: { self.leaderboard() }) {
                HStack {
                    Image(systemName: "gamecontroller")
                    Text("LEADERBOARD")
                }
            }
        }
            .imageScale(.large)

        .modifier(DefaultButton())
        .padding(24)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(newGame: {}, leaderboard: {})
    }
}
