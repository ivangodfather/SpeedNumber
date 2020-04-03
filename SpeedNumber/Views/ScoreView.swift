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
    let maxScore: String?
    
    let completion: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Your final score is")
                .font(Font.system(.headline, design: .monospaced))
            Text(score)
                .font(Font.system(size: 64, design: .monospaced))
            Spacer()
            if maxScore != nil {
                Text("Your best score is")
                    .font(Font.system(.headline, design: .monospaced))
                Text(maxScore!)
                    .font(Font.system(size: 32, design: .monospaced))
                    .padding(.bottom, 32)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .onTapGesture {
            self.completion()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: "32.2", maxScore: "20.0", completion: {})
    }
}
