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
    
    let versionText: String
    let newGame: () -> ()
    let leaderboard: () -> ()
    
    var body: some View {
        VStack {
            Text(versionText)
                .modifier(FootNodeLabel())
            Spacer()
            Text("Tap to start")
                .modifier(LargeTitleLabel())
            Text("Try to follow de sequence as fast as you can!")
                .padding(32)
                .modifier(BodyLabel())
            Spacer()
            Button(action: { self.leaderboard() }) {
                HStack {
                    Image(systemName: "gamecontroller")
                        .imageScale(.large)
                    Text("LEADERBOARD")
                }
            }
            .modifier(DefaultButton())


        }
        .onTapGesture {
            self.newGame()
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView(versionText: "Speedy v0.1", newGame: {}, leaderboard: {})
    }
}
