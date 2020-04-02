//
//  ScoreView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    let score: String
    let completion: () -> ()
    
    var body: some View {
        VStack {
            Text("Your final score is")
                .font(Font.system(.headline, design: .monospaced))
            Text(score)
                .font(Font.system(size: 56, design: .monospaced))
        }.onTapGesture {
            self.completion()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: "32.2", completion: {})
    }
}
