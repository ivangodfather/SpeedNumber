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
                .padding(.all)
            Spacer()
            Image(uiImage: UIImage(named: "logo")!)
                .resizable()
                .frame(width: 150, height: 150)
            Text("Speedy Numbers")
                .modifier(LargeTitleLabel())
            Text(Translation.mainSubtitle)
                .padding(32)
                .modifier(BodyLabel())
            Spacer()
            MenuView(newGame: newGame, leaderboard: leaderboard)

        }
        .background(Color(UIColor.systemBackground))
        .onTapGesture {
            self.newGame()
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeScreenView(versionText: "Speedy v0.1", newGame: {}, leaderboard: {})
            WelcomeScreenView(versionText: "Speedy v0.1", newGame: {}, leaderboard: {})
                .environment(\.colorScheme, .dark)
        }
        .background(Color(UIColor.systemBackground))

    }
}
